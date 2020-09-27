# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    class Quality
      enable_simple_cache
      include ::Comparable

      POSITIVE_MARGIN = 0.75
      LIST = [240, 480, 720, 1080, 2160].freeze

      class << self
        enable_simple_cache

        def by_height(height)
          list.find { |v| v.height == height }
        end

        private

        def list_uncached
          preceding = nil
          LIST.map { |height| preceding = new(height, preceding) }
        end
      end

      attr_reader :following

      common_constructor :height, :preceding do
        preceding&.send('following=', self)
      end

      def <=>(other)
        height <=> other.height
      end

      def to_s
        height.to_s
      end

      def to_xs
        "#{height} (Min: #{min_height}, Max: #{max_height})"
      end

      def resolution_match?(resolution)
        (min_height.blank? || resolution.lower >= min_height) &&
          (max_height.blank? || resolution.lower <= max_height)
      end

      private

      attr_writer :following

      def max_height_uncached
        following.if_present do |v|
          delta = v.height - height
          height + (delta * POSITIVE_MARGIN).to_i
        end
      end

      def min_height_uncached
        preceding.if_present { |v| v.max_height + 1 }
      end
    end
  end
end
