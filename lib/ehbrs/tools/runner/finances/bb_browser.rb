# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Finances
        class BbBrowser
          DOWNLOADS_CONTAINER_PATH = '/downloads'
          NOVNC_ADDRESS = '127.0.0.1'
          NOVNC_CONTAINER_PORT = 6080
          NOVNC_HOST_PORT = 6080
          SHM_SIZE = '2g'
          VNC_PASSWORD_LENGTH = 8

          runner_with :help do
            desc 'Bankline para Banco do Brasil com módulo de segurança.'
          end

          def run
            infov 'Browser URL', browser_url
            open_browser_when_ready
            infov 'System result', docker_container.run_command(docker_run_extra_args).system
          end

          private

          # @return [String]
          memoize def browser_url
            "http://#{NOVNC_ADDRESS}:#{NOVNC_HOST_PORT}/vnc.html?autoconnect=1&resize=remote" \
              "&password=#{vnc_password}"
          end

          # @return [EacDocker::Container]
          memoize def docker_container
            r = docker_image.container.temporary(true).interactive(true).tty(true)
            %w[environment_variables volumes].inject(r) do |a, e|
              send("docker_container_#{e}", a)
            end
          end

          # @param container [EacDocker::Container]
          # @return [EacDocker::Container]
          def docker_container_environment_variables(container)
            {
              'USER_GID' => group_id,
              'USER_UID' => user_id,
              'VNC_PASSWORD' => vnc_password
            }.inject(container) { |a, e| a.env(e[0], e[1]) }
          end

          # @param container [EacDocker::Container]
          # @return [EacDocker::Container]
          def docker_container_volumes(container)
            container.volume(::File.join(Dir.home, 'Downloads'), DOWNLOADS_CONTAINER_PATH)
          end

          # @return [EhbrsRubyUtils::Finances::BbBrowser::DockerImage]
          memoize def docker_image
            ::EhbrsRubyUtils::Finances::BbBrowser::DockerImage.create
          end

          # @return [Array<String>]
          def docker_run_extra_args
            ['--init', '--shm-size', SHM_SIZE, '--publish',
             "#{NOVNC_ADDRESS}:#{NOVNC_HOST_PORT}:#{NOVNC_CONTAINER_PORT}"]
          end

          # @return [String]
          def group_id
            ::EacRubyUtils::Envs.local.command('id', '-g').execute!.strip
          end

          # @return [Boolean]
          def novnc_ready?
            ::Net::HTTP.get_response(::URI.parse(browser_url)).is_a?(::Net::HTTPSuccess)
          rescue ::SystemCallError, ::IOError
            false
          end

          # @return [void]
          def open_browser
            ::EacRubyUtils::Envs.local.command('xdg-open', browser_url).execute
          end

          # @return [Thread]
          def open_browser_when_ready
            ::Thread.new do
              sleep 1 until novnc_ready?
              open_browser
            end
          end

          # @return [String]
          def user_id
            ::EacRubyUtils::Envs.local.command('id', '-u').execute!.strip
          end

          # @return [String]
          memoize def vnc_password
            ::SecureRandom.alphanumeric(VNC_PASSWORD_LENGTH)
          end
        end
      end
    end
  end
end
