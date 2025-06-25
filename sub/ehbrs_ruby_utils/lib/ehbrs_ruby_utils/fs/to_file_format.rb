# frozen_string_literal: true

require 'eac_fs/patches'

module EhbrsRubyUtils
  module Fs
    class ToFileFormat
      enable_abstract_methods
      enable_simple_cache
      abstract_methods :convert, :convert?, :target_encoding

      TEXT_MIME_TYPES = [%r{\Atext/\S+}].freeze

      common_constructor(:file) do
        self.file = file.to_pathname
      end

      class << self
        def convert_self(file)
          new(file).run
        end

        def convert_to_file(source, target)
          ::FileUtils.cp(source, target)
          convert_self(target)
        end

        def convert_to_string(source)
          ::EacRubyUtils::Fs::Temp.on_file do |target|
            convert_to_file(source, target)
            target.open('rb', &:read)
          end
        end
      end

      def run # rubocop:disable Naming/PredicateMethod
        return false unless convert?

        convert
        true
      end

      protected

      def convert_to_target_encoding
        ::EacRubyUtils::Fs::Temp.on_file do |temp|
          ::EacRubyUtils::Envs.local.command(
            'iconv', '-c', '-f', source_encoding, '-t', target_encoding, '-o', temp, file
          ).execute!
          ::FileUtils.mv(temp, file)
        end
        reset_cache
      end

      def crlf?
        file_type?('CRLF')
      end

      def file_info_uncached
        ::EacFs::FileInfo.new(file)
      end

      def file_type?(*include)
        return false unless ::File.file?(file)

        include.any? { |i| file_type.include?(i) }
      end

      def file_type_uncached
        ::EacRubyUtils::Envs.local.command('file', '-b', file).execute!.strip
      end

      def source_encoding
        r = file.info.charset
        r = 'iso-8859-15' if r == 'unknown-8bit'
        r
      end

      # @return [Boolean]
      def text?
        TEXT_MIME_TYPES.any? { |e| e.match?(file.info.content_type.mime_type) }
      end
    end
  end
end
