# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs_ruby_utils/web_utils/videos/files_list'
require 'json'
require 'yaml'

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Videos
          class Upload
            runner_with :help do
              desc 'Exporta informações de arquivos de vídeo para uma instância EHB/RS Utils.'
              bool_opt '-P', '--no-ffprobe', 'Não recupera dados com "ffprobe".'
            end

            def run
              %w[movies series].each { |type| upload_files_list(type) }
            end

            def upload_files_list(type)
              infom "Uploading \"#{type}\" files list..."
              files_list_path = send("#{type}_files_list")
              infov 'Path', files_list_path
              process_response(files_list_path)
            end

            def upload_request(files_list_path)
              runner_context.call(:instance).http_request(
                '/videos/files/import',
                method: :put,
                body: {
                  'videos_local_files_import_list[list_file]' => ::File.new(files_list_path)
                },
                header: {
                  'Accept' => 'application/json'
                }
              )
            end

            def process_response(files_list_path)
              upload_request(files_list_path).body
            rescue ::EhbrsRubyUtils::WebUtils::RequestError => e
              system('firefox', e.body_file_path.to_path)
              fatal_error("Retornou com erro: #{e.message}")
            end

            def series_files_list_uncached
              write_files_list('Videos::SeriesDirectory', :series_directory)
            end

            def movies_files_list_uncached
              write_files_list('Videos::MovieFile', :movies_directory)
            end

            def write_files_list(file_class, read_entry)
              files_list = ::EhbrsRubyUtils::WebUtils::Videos::FilesList.new(
                file_class,
                runner_context.call(:instance).read_entry(read_entry),
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
