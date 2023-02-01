# frozen_string_literal: true

require 'eac_ruby_utils/envs'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Executables
    class << self
      enable_simple_cache

      def env
        ::EacRubyUtils::Envs.local
      end

      private

      {
        '-version' => %w[ffmpeg ffprobe]
      }.each do |validate_arg, commands|
        commands.each do |command|
          define_method("#{command}_uncached") do
            env.executable(command, validate_arg)
          end
        end
      end
    end
  end
end
