# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  class SpreaderT1
    module BaseLevel
      extend ::Comparable

      def <=>(other)
        s = remaining_f <=> other.remaining_f
        return s unless s.zero?

        s = total_i <=> other.total_i
        return s unless s.zero?

        other.label <=> label
      end

      def remaining?
        remaining_i.positive?
      end

      def remaining_f
        remaining_i.to_f / total_i
      end

      def remaining_fs
        ((remaining_f * 1000).round / 10.0).to_s + '%'
      end

      def debugs
        [label, remaining_fs, total_i].join(' / ')
      end
    end
  end
end
