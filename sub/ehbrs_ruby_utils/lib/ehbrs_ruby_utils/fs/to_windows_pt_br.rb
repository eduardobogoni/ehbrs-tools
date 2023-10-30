# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/fs/to_file_format'

module EhbrsRubyUtils
  module Fs
    class ToWindowsPtBr < ::EhbrsRubyUtils::Fs::ToFileFormat
      TARGET_CHARSETS = %w[ISO-8859].freeze
      ICONV_TO = 'ISO-8859-1'

      protected

      def convert
        check_bom
        check_target_charset
        check_crlf
      end

      private

      def check_bom
        ::EacRubyUtils::Envs.local.command(
          'sed', '-i', '1s/^\\xEF\\xBB\\xBF//', file
        ).system!
        reset_cache
      end

      def check_target_charset
        return if target_charset?

        convert_to_target_encoding
      end

      def check_crlf
        return if crlf?

        convert_crlf
      end

      def convert_crlf
        ::EacRubyUtils::Envs.local.command('unix2dos', file).execute!
        reset_cache
      end

      def convert?
        text? && (!target_charset? || !crlf?)
      end

      def target_charset?
        file_type?(*TARGET_CHARSETS)
      end

      def target_encoding
        ICONV_TO
      end
    end
  end
end
