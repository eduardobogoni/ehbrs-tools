# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Videos
          class Repositories
            LIST_COLUMNS = %w[id name videos_type path].freeze

            runner_with :help, :output_list do
              desc 'Lista os repositórios de arquivos de vídeos de uma instância EHB/RS Utils.'
            end

            def run
              run_output
            end

            protected

            # @return [Array<String>]
            def list_columns
              LIST_COLUMNS
            end

            # @return [Array<Hash>]
            def list_rows
              runner_context.call(:instance).videos_files_repositories
            end
          end
        end
      end
    end
  end
end
