# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'
require 'ehbrs_ruby_utils/music/sort/files/scanner'

module Ehbrs
  module Tools
    class Runner
      class Music
        class Sort
          DEFAULT_PATH = '.'

          runner_with :help, :subcommands do
            desc 'Ordena arquivos/diretórios prefixando-os.'
            arg_opt '-C', '--path', 'Path to the directory.', default: DEFAULT_PATH
            subcommands
          end
          for_context :path, :scanner, :config_file

          # @return [Pathname]
          delegate :config_file, to: :scanner

          # @return [Pathname]
          def path
            parsed.path.to_pathname
          end

          private

          # @return [EhbrsRubyUtils::Music::Sort::Files::Scanner]
          def scanner_uncached
            ::EhbrsRubyUtils::Music::Sort::Files::Scanner.new(path)
          end

          require_sub __FILE__
        end
      end
    end
  end
end
