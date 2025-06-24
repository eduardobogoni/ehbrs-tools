# frozen_string_literal: true

module EhbrsRubyUtils
  class CircularListSpreader
    class ItemLevel
      include ::EhbrsRubyUtils::CircularListSpreader::BaseLevel

      common_constructor :item do
        self.removed = false
      end

      def label
        item.to_s
      end

      def pop
        raise 'Item already removed' if removed?

        self.removed = true
        self
      end

      def remaining_i
        removed? ? 0 : 1
      end

      def removed?
        @removed
      end

      def total_i
        1
      end

      private

      attr_writer :removed
    end
  end
end
