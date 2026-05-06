# frozen_string_literal: true

module EhbrsRubyUtils
  module Aranha
    class AccommodationsProcessor
      acts_as_abstract
      enable_memoized
      common_constructor :url

      SCROLL_DOWN_STEP = 500

      # @return [Array]
      def accommodations
        data.fetch(:accommodations).map { |a| build_accommodation(a) }
      end

      # @return [Integer]
      def declared_count
        data.fetch(:declared_count)
      end

      protected

      # @return [Boolean]
      def all_data_loaded?
        raise_abstract_method __method__
      end

      # @param accommodation_data [Hash]
      # @return [Hash]
      def build_accommodation(_accommodation_data)
        raise_abstract_method __method__
      end

      def data
        @data ||= begin
          session.navigate.to url
          session.wait(5.minutes).until do
            scroll_down
            all_data_loaded?
          end
          parser.data
        end
      end

      # @return [Object]
      def parser
        parser_class.from_string(session.current_source)
      end

      # @return [Class]
      def parser_class
        [self.class.module_parent.module_parent.name, 'Parsers', self.class.name.demodulize]
          .join('::').constantize
      end

      # @return [Aranha::Selenium::Session]
      def session
        raise_abstract_method __method__
      end

      # @return [void]
      def scroll_down
        session.scroll_down_by(SCROLL_DOWN_STEP)
      end

      require_sub __FILE__, require_mode: :kernel
    end
  end
end
