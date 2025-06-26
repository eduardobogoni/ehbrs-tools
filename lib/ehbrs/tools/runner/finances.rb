# frozen_string_literal: true

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
