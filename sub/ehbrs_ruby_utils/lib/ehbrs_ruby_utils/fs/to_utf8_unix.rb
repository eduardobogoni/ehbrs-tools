# frozen_string_literal: true

require 'ehbrs_ruby_utils/fs/to_file_format'

module EhbrsRubyUtils
  module Fs
    class ToUtf8Unix < ::EhbrsRubyUtils::Fs::ToFileFormat
      UTF8_ENCODINGS = %w[us-ascii utf-8].freeze
      ISO885915_ENCODINGS = %w[iso-8859-1].freeze

      protected

      def convert
        check_utf8
        check_crlf
      end

      def check_utf8
        return if utf8?

        convert_to_target_encoding
        reset_cache
      end

      def file_attr(option)
        ::EacRubyUtils::Envs.local.command('file', '--brief', option, file).execute!
      end

      def mime_encoding_uncached
        file_attr('--mime-encoding')
      end

      def check_crlf
        return unless crlf?

        convert_crlf
      end

      def convert_crlf
        ::EacRubyUtils::Envs.local.command('dos2unix', file).execute!
      end

      def convert?
        text? && (!utf8? || crlf?)
      end

      def utf8?
        UTF8_ENCODINGS.include?(mime_encoding)
      end

      def iso885915?
        ISO885915_ENCODINGS.include?(mime_encoding)
      end

      def target_encoding
        'utf-8'
      end
    end
  end
end
