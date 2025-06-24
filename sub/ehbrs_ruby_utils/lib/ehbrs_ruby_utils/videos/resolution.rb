# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    class Resolution
      enable_simple_cache
      include ::Comparable

      class << self
        def valid_dimension?(dimension)
          dimension.is_a?(::Integer) && dimension.positive?
        end
      end

      common_constructor :width, :height

      def <=>(other)
        r = (lower <=> other.lower)
        return r unless r.zero?

        higher <=> other.higher
      end

      def to_xs
        [quality_to_s, resolution_to_s].join(' / ')
      end

      def higher
        [width, height].max
      end

      def lower
        [width, height].min
      end

      def pixels
        width * height
      end

      def quality_to_s
        quality.if_present('?', &:to_s)
      end

      def resolution_to_s
        "#{width}x#{height}"
      end

      def to_s
        resolution_to_s
      end

      def valid?
        [width, height].all? { |d| self.class.valid_dimension?(d) }
      end

      private

      def quality_uncached
        ::EhbrsRubyUtils::Videos::Quality.list
          .find { |quality| quality.resolution_match?(self) } ||
          raise("No quality matches resolution #{resolution}")
      end
    end
  end
end
