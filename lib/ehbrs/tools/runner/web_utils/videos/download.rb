# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Videos
          class Download
            runner_with :confirmation, :help, :'web_utils/videos/files_repositories_selector' do
              desc 'Importa informações de arquivos de vídeo de uma instância EHB/RS Utils.'
              bool_opt '-d', '--delete', 'Remove vídeos indesejados.'
              arg_opt '-m', '--move', 'Move vídeos indesejados para o diretório indicado.'
            end

            def run
              repositories.each { |repository| process_repository(repository) }
            end

            private

            def delete?
              parsed.delete? && !move?
            end

            def move?
              parsed.move.present?
            end

            # @param repository [Hash]
            # @return [void]
            def process_repository(repository)
              files = repository_files(repository)
              start_banner(repository, files)
              to_rename(files).each { |file| process_rename_file(file) }
              unwanted(files).each { |file| process_unwanted_file(file) }
            end

            # @param repository [Hash]
            # @param files [Array<EhbrsRubyUtils::WebUtils::Videos::File>]
            # @return [void]
            def start_banner(repository, files)
              infov 'Repository', "#{repository.fetch('id')} | #{repository.fetch('name')}"
              infov 'Files downloaded', files.count
              infov 'To rename', to_rename(files).count
              infov 'Unwanted', unwanted(files).count
            end

            def process_rename_file(file)
              infov "  * #{file.new_path}", file.original_path
              file.rename if confirm?
            end

            def process_unwanted_file(file)
              infov "  * #{file.new_path}", 'UNWANTED'
              file.remove if delete? && confirm?
              file.move(parsed.move) if move? && confirm?
            end

            # @param repository [Hash]
            # @return [Array<EhbrsRubyUtils::WebUtils::Videos::File>]
            def repository_files(repository)
              runner_context.call(:instance).http_request(repository_files_url_suffix(repository))
                .body.map { |file_data| ::EhbrsRubyUtils::WebUtils::Videos::File.new(file_data) }
            end

            # @param repository [Hash]
            # @return [String]
            def repository_files_url_suffix(repository)
              "/videos/files_repositories/#{repository.fetch('id')}/files_export"
            end

            # @param files [Array<EhbrsRubyUtils::WebUtils::Videos::File>]
            # @return [Array<EhbrsRubyUtils::WebUtils::Videos::File>]
            def to_rename(files)
              files.select(&:path_changed?)
            end

            # @param files [Array<EhbrsRubyUtils::WebUtils::Videos::File>]
            # @return [Array<EhbrsRubyUtils::WebUtils::Videos::File>]
            def unwanted(files)
              files.reject { |f| f.type == 'Videos::SeriesDirectory' }.select(&:unwanted)
            end
          end
        end
      end
    end
  end
end
