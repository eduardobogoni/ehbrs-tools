# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Finances
        runner_with :help, :subcommands do
          desc 'Utilidades financeiras.'
          subcommands
        end
      end
    end
  end
end
