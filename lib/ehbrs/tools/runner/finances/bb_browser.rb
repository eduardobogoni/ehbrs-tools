# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Finances
        class BbBrowser
          CONTAINER_ENV_FORMAT = '{{range .Config.Env}}{{println .}}{{end}}'
          DEFAULT_CONTAINER_NAME = 'ehbrs-tools-bb-browser'
          DEFAULT_DOCKER_COMMAND = 'podman'
          DOWNLOADS_CONTAINER_PATH = '/downloads'
          NOVNC_ADDRESS = '127.0.0.1'
          NOVNC_CONTAINER_PORT = 6080
          NOVNC_HOST_PORT = 6080
          PODMAN_RUN_EXTRA_ARGS = %w[--userns=keep-id --user 0].freeze
          SHM_SIZE = '2g'
          VNC_PASSWORD_LENGTH = 8

          runner_with :help do
            desc 'Bankline para Banco do Brasil com módulo de segurança.'
            arg_opt '-n', '--container-name', 'Nome do contêiner.',
                    default: DEFAULT_CONTAINER_NAME
          end

          def run
            setup_docker_command
            infov 'Container name', parsed.container_name
            infov 'Browser URL', browser_url
            open_browser_when_ready
            infov 'System result', container_command.system
          end

          private

          # @return [String]
          memoize def browser_url
            "http://#{NOVNC_ADDRESS}:#{NOVNC_HOST_PORT}/vnc.html?autoconnect=1&resize=remote" \
              "&password=#{vnc_password}"
          end

          # @return [EacRubyUtils::Envs::Command]
          def container_command
            if container_exist?
              docker_container.start_command
            else
              docker_container.env('VNC_PASSWORD', vnc_password)
                .run_command(docker_run_extra_args)
            end
          end

          # @return [Hash<String, String>]
          def container_env
            ::EacDocker::Executables.docker
              .command('container', 'inspect', '--format', CONTAINER_ENV_FORMAT,
                       parsed.container_name)
              .execute!.lines.filter_map { |line| line.chomp.split('=', 2).presence }.to_h
          end

          # @return [Boolean]
          memoize def container_exist?
            docker_container.exist?
          end

          # @return [EacDocker::Container]
          memoize def docker_container
            r = docker_image.container.name(parsed.container_name).interactive(true).tty(true)
            %w[environment_variables volumes].inject(r) do |a, e|
              send("docker_container_#{e}", a)
            end
          end

          # @param container [EacDocker::Container]
          # @return [EacDocker::Container]
          def docker_container_environment_variables(container)
            {
              'USER_GID' => group_id,
              'USER_UID' => user_id
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
             "#{NOVNC_ADDRESS}:#{NOVNC_HOST_PORT}:#{NOVNC_CONTAINER_PORT}"] +
              (podman? ? PODMAN_RUN_EXTRA_ARGS : [])
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

          # @return [Boolean]
          memoize def podman?
            ::EacDocker::Executables.docker.command('--version').execute!.downcase.include?('podman')
          end

          # @return [void]
          def setup_docker_command
            ENV[::EacDocker::Executables.docker.executable_args_envvar] ||= DEFAULT_DOCKER_COMMAND
          end

          # @return [String]
          def user_id
            ::EacRubyUtils::Envs.local.command('id', '-u').execute!.strip
          end

          # @return [String]
          memoize def vnc_password
            return container_env.fetch('VNC_PASSWORD') if container_exist?

            ::SecureRandom.alphanumeric(VNC_PASSWORD_LENGTH)
          end
        end
      end
    end
  end
end
