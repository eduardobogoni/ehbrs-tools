# frozen_string_literal: true

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
        end
      end
    end
  end
end
