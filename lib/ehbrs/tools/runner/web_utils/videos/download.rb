# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'
require 'ehbrs_ruby_utils/web_utils/videos/file'

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Videos
          class Download
            runner_with :confirmation, :help do
              desc 'Importa informações de arquivos de vídeo de uma instância EHB/RS Utils.'
              bool_opt '-d', '--delete', 'Remove vídeos indesejados.'
            end

            def run
              start_banner
              to_rename.each { |file| process_rename_file(file) }
              unwanted.each { |file| process_unwanted_file(file) }
            end

            private

            def delete?
              parsed.delete?
            end

            def start_banner
              infov 'Files downloaded', files.count
              infov 'To rename', to_rename.count
              infov 'Unwanted', unwanted.count
            end

            def process_rename_file(file)
              infov "  * #{file.new_path}", file.original_path
              file.rename if confirm?
            end

            def process_unwanted_file(file)
              infov "  * #{file.new_path}", 'UNWANTED'
              file.remove if delete? && confirm?
            end

            def files_uncached
              data.map { |file_data| ::EhbrsRubyUtils::WebUtils::Videos::File.new(file_data) }
            end

            def to_rename_uncached
              files.select(&:path_changed?)
            end

            def unwanted_uncached
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
