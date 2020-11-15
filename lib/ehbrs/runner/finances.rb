# frozen_string_literal: true

require 'eac_cli/core_ext'

module Ehbrs
  class Runner
    class Finances
      require_sub __FILE__

      runner_with :help, :subcommands do
        desc 'Utilidades financeiras.'
        subcommands
      end
    end
  end
end
