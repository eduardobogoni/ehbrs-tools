# frozen_string_literal: true

require 'avm/files/info'
require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Fs
    class CompressedPackage < ::Avm::Files::Info
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
        ::Ehbrs::Executables.sevenzip.command('x', path, '-o', target_dir)
      end

      def tar_extract_command(target_dir)
        ::Ehbrs::Executables.tar.command('-xf', path, '-C', target_dir)
      end

      def rar_extract_command(target_dir)
        ::Ehbrs::Executables.rar.command('x', path.expand_path).chdir(target_dir)
      end

      def zip_extract_command(target_dir)
        ::Ehbrs::Executables.unzip.command(path, '-d', target_dir)
      end
    end
  end
end
