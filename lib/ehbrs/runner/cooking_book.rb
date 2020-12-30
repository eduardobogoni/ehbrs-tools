# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/cooking_book/project'

module Ehbrs
  class Runner
    class CookingBook
      require_sub __FILE__

      DEFAULT_SOURCE_DIR = '.'

      runner_with :help, :subcommands do
        desc 'Operações para livros de receitas.'
        arg_opt '-C', '--source-dir', 'Caminho para o diretório do código-fonte.'
        subcommands
      end

      private

      def source_dir_uncached
        (parsed.source_dir || DEFAULT_SOURCE_DIR).to_pathname.expand_path
      end

      def project_uncached
        ::Ehbrs::CookingBook::Project.new(source_dir)
      end
    end
  end
end
