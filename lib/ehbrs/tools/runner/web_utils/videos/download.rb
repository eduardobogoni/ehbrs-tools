# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs_ruby_utils/web_utils/videos/file'

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Videos
          class Download
            runner_with :help do
              desc 'Importa informações de arquivos de vídeo de uma instância EHB/RS Utils.'
              bool_opt '-c', '--confirm', 'Confirma as mudanças'
            end

            def run
              start_banner
              to_rename.each { |file| process_rename_file(file) }
              to_delete.each { |file| process_delete_file(file) }
            end

            private

            def start_banner
              infov 'Files downloaded', files.count
              infov 'To rename', to_rename.count
              infov 'To delete', to_delete.count
            end

            def process_rename_file(file)
              infov "  * #{file.new_path}", file.original_path
              file.rename if parsed.confirm?
            end

            def process_delete_file(file)
              infov "  * #{file.new_path}", 'REMOVE'
              file.remove if parsed.confirm?
            end

            def files_uncached
              data.map { |file_data| ::EhbrsRubyUtils::WebUtils::Videos::File.new(file_data) }
            end

            def to_rename_uncached
              files.select(&:path_changed?)
            end

            def to_delete_uncached
              files.reject { |f| f.type == 'Videos::SeriesDirectory' }.select(&:unwanted)
            end

            def data_uncached
              ::JSON.parse(raw_content)
            end

            def raw_content
              runner_context.call(:instance).http_request('/videos/files/export').body
            end
          end
        end
      end
    end
  end
end
