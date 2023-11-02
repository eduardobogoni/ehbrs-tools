# frozen_string_literal: true

require 'eac_ruby_utils/envs'
require 'eac_ruby_utils/simple_cache'

module Ehbrs
  module Executables
    class << self
      include ::EacRubyUtils::SimpleCache

      def env
        ::EacRubyUtils::Envs.local
      end

      private

      {
        '-h' => %w[unzip],
        '-version' => %w[ffmpeg],
        '--version' => %w[flips tar wit]
      }.each do |validate_arg, commands|
        commands.each do |command|
          define_method("#{command}_uncached") do
            env.executable(command, validate_arg)
          end
        end
      end

      def sevenzip_uncached
        env.executable('7z', '--help')
      end
    end
  end
end
