# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Fs
        runner_with :help, :subcommands do
          desc 'Ferramentas para o sistema de arquivos.'
          subcommands
        end
      end
    end
  end
end
