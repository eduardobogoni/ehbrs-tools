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

      def floating_ips
        @floating_ips ||= env.executable('flips-linux', '--version')
      end

      private

      %w[ffmpeg ffprobe].each do |command|
        define_method("#{command}_uncached") do
          env.executable(command, '-version')
        end
      end
    end
  end
end
