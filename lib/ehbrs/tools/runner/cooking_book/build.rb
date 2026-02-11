# frozen_string_literal: true

require 'os'

module Ehbrs
  module Tools
    class Runner
      class CookingBook
        class Build
          runner_with :help, :subcommands do
            desc 'Operações para livros de receitas.'
            arg_opt '-d', '--target-dir', 'Caminho para o diretório destino da construção.'
            bool_opt '--open', 'Show the result.'
          end

          def run
            start_banner
            build.run
            open
            success 'Done'
          end

          private

          def build_uncached
            ::EhbrsRubyUtils::CookingBook::Build.new(
              runner_context.call(:project), target_dir: parsed.target_dir
            )
          end

          def open
            return unless parsed.open?

            infom "Opening \"#{open_path}\"..."
            ::EacRubyUtils::Envs.local.command(OS.open_file_command, open_path).system!
          end

          def open_path
            build.index_page.target_path
          end

          def start_banner
            infov 'Project', build.project
            infov 'Target directory', build.target_dir
          end
        end
      end
    end
  end
end
