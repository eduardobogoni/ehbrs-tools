# frozen_string_literal: true

require 'eac_cli/core_ext'

module Ehbrs
  class Runner
    class Fs
      require_sub __FILE__

      runner_with :help, :subcommands do
        desc 'Ferramentas para o sistema de arquivos.'
        subcommands
      end
    end
  end
end
