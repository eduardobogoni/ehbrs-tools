# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/videos/extract/package'
require 'eac_docker/images/named'

module Ehbrs
  class Runner
    class Finances
      class BbBrowser
        runner_with :help do
          desc 'Bankline para Banco do Brasil com módulo de segurança.'
        end

        def run
          infov 'Docker run arguments', docker_container.run_command_args
          infov 'System result', docker_container.run_command.system
        end

        private

        def docker_image_uncached
          ::EacDocker::Images::Named.new('lichti/warsaw-browser')
        end

        def docker_container_uncached
          docker_image.container.env('DISPLAY', "unix#{ENV.fetch('DISPLAY')}")
                      .volume(::File.join(ENV['HOME'], 'Downloads'), '/home/bank/Downloads')
                      .volume('/tmp/.X11-unix', '/tmp/.X11-unix').command_arg('bb')
                      .temporary(true).interactive(true).tty(true)
        end
      end
    end
  end
end
