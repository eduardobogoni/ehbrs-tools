# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Videos
          class Upload
            DEFAULT_TIMEOUT = 5.minutes

            runner_with :help, :'web_utils/videos/files_repositories_selector' do
              desc 'Exporta informações de arquivos de vídeo para uma instância EHB/RS Utils.'
              bool_opt '-P', '--no-ffprobe', 'Não recupera dados com "ffprobe".'
              arg_opt '-t', '--timeout', 'Tempo limite (em segundos) do envio.',
                      default: DEFAULT_TIMEOUT.to_i
            end

            def run
              repositories.each { |repository| upload_repository(repository) }
            end

            # @return [Integer]
            def timeout
              parsed.timeout.to_i
            end

            # @param repository [Hash]
            # @return [void]
            def upload_repository(repository)
              infom "Uploading files list of repository \"#{repository.fetch('id')} | " \
                    "#{repository.fetch('name')}\"..."
              files_list_path = write_files_list(repository)
              infov 'Path', files_list_path
              process_response(repository, files_list_path)
            end

            # @param repository [Hash]
            # @param files_list_path [String]
            def upload_request(repository, files_list_path)
              runner_context.call(:instance).http_request(
                "/videos/files_repositories/#{repository.fetch('id')}/files_import",
                method: :put,
                body: {
                  'videos_local_files_import_list[list_file]' => ::File.new(files_list_path)
                },
                header: { 'Accept' => 'application/json' },
                timeout: timeout
              )
            end

            # @param repository [Hash]
            # @param files_list_path [String]
            def process_response(repository, files_list_path)
              upload_request(repository, files_list_path).body
            rescue ::EhbrsRubyUtils::WebUtils::RequestError => e
              system('firefox', e.body_file_path.to_path)
              fatal_error("Retornou com erro: #{e.message}")
            end

            # @param repository [Hash]
            # @return [String]
            def write_files_list(repository)
              files_list = ::EhbrsRubyUtils::WebUtils::Videos::FilesList.new(
                repository.fetch('files_type'), repository.fetch('path'),
                ffprobe: !parsed.no_ffprobe?
              )
              infov 'Files found', files_list.data.fetch(:files).count
              files_list.write_to
            end
          end
        end
      end
    end
  end
end
