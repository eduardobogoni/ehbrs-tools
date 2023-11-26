# frozen_string_literal: true

require 'ehbrs/tools/core_ext'
require 'ehbrs_ruby_utils/finances/bb_browser/docker_image'

module Ehbrs
  module Tools
    class Runner
      class Finances
        class BbBrowser
          runner_with :help do
            desc 'Bankline para Banco do Brasil com módulo de segurança.'
          end

          def run
            infov 'Docker run arguments', ::Shellwords.join(docker_container.run_command_args)
            infov 'System result', docker_container.run_command.system
          end

          private

          def docker_image_uncached
            ::EhbrsRubyUtils::Finances::BbBrowser::DockerImage.create
          end

          def docker_container_uncached
            r = docker_image.container
                  .temporary(true).interactive(true).tty(true)
                  .command_arg('seg.bb.com.br')
            %w[capabilities environment_variables volumes].inject(r) do |a, e|
              send("docker_container_#{e}", a)
            end
          end

          def docker_container_capabilities(container)
            %w[CAP_AUDIT_WRITE CAP_SYS_PTRACE].inject(container) { |a, e| a.capability(e) }
          end

          def docker_container_environment_variables(container)
            {
              'USER_UID' => user_id,
              'USER_GID' => group_id
            }.inject(container) { |a, e| a.env(e[0], e[1]) }
          end

          def docker_container_volumes(container)
            {
              ::File.join(Dir.home, 'Downloads') => '/home/user/Downloads',
              ::File.join(Dir.home, '.Xauthority') => '/home/user/.Xauthority:ro',
              '/tmp/.X11-unix' => '/tmp/.X11-unix:ro',
              '/etc/machine-id' => '/etc/machine-id:ro'
            }.inject(container) { |a, e| a.volume(e[0], e[1]) }
          end

          def user_id
            ::EacRubyUtils::Envs.local.command('id', '-u').execute!.strip
          end

          def group_id
            ::EacRubyUtils::Envs.local.command('id', '-g').execute!.strip
          end
        end
      end
    end
  end
end
