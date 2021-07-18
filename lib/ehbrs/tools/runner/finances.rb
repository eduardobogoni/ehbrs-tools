# frozen_string_literal: true

require 'eac_cli/core_ext'

module Ehbrs
  module Tools
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
end
