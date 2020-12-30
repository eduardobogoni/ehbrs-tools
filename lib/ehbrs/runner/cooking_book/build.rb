# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/cooking_book/build'

module Ehbrs
  class Runner
    class CookingBook
      class Build
        runner_with :help, :subcommands do
          desc 'Operações para livros de receitas.'
          arg_opt '-d', '--target-dir', 'Caminho para o diretório destino da construção.'
        end

        def run
          infov 'Project', build.project
          infov 'Target directory', build.target_dir
          build.run
          success 'Done'
        end

        private

        def build_uncached
          ::Ehbrs::CookingBook::Build.new(
            runner_context.call(:project), target_dir: parsed.target_dir
          )
        end
      end
    end
  end
end
