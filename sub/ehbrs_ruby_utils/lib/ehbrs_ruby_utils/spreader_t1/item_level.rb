# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/spreader_t1/base_level'

module EhbrsRubyUtils
  class SpreaderT1
    class ItemLevel
      include ::EhbrsRubyUtils::SpreaderT1::BaseLevel

      common_constructor :item do
        self.removed = false
      end

      def label
        item.to_s
      end

      def pop
        raise 'Item already removed' if removed?

        self.removed = true
        item
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
