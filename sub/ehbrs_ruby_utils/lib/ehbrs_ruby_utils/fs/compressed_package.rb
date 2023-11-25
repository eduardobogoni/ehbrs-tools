# frozen_string_literal: true

require 'eac_fs/file_info'
require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/executables'

module EhbrsRubyUtils
  module Fs
    class CompressedPackage < ::EacFs::FileInfo
      MIME_TYPES = {
        'application/zip' => :zip,
        'application/x-7z-compressed' => :sevenzip,
        'application/x-rar' => :rar,
        'application/x-tar' => :tar
      }.freeze

      def extract_to(target)
        target = target.to_pathname
        target.mkpath
        sub_extract_to(target)
      end

      private

      def sub_extract_to(target)
        MIME_TYPES[content_type.mime_type].if_present do |v|
          return send("#{v}_extract_command", target).execute!
        end
        raise "Unknown how to extract \"#{path}\" (#{content_type})"
      end

      def sevenzip_extract_command(target_dir)
        ::EhbrsRubyUtils::Executables.sevenzip.command('x', path, '-o', target_dir)
      end

      def tar_extract_command(target_dir)
        ::EhbrsRubyUtils::Executables.tar.command('-xf', path, '-C', target_dir)
      end

      def rar_extract_command(target_dir)
        ::EhbrsRubyUtils::Executables.rar.command('x', path.expand_path).chdir(target_dir)
      end

      def zip_extract_command(target_dir)
        ::EhbrsRubyUtils::Executables.unzip.command(path, '-d', target_dir)
      end
    end
  end
end
