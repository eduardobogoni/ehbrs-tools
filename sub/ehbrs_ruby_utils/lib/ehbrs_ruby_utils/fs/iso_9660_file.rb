# frozen_string_literal: true

module EhbrsRubyUtils
  module Fs
    class Iso9660File
      DEFAULT_EXTNAME = '.iso'

      common_constructor :path do
        self.path = path.to_pathname
      end

      # @return [Array<String>]
      def list
        isoinfo_command('-f').execute!.each_line
      end

      # @param command_args [Array<String>]
      # @return [EacRubyUtils::Envs::Command]
      def isoinfo_command(*command_args)
        ::EacRubyUtils::Envs.local.command('isoinfo', '-i', path, *command_args)
      end

      # @return [Boolean]
      def valid?
        isoinfo_command.execute.fetch(:exit_code).zero?
      end
    end
  end
end
