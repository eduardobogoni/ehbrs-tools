# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Google
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Utilidades Google.'
          subcommands
        end
      end
    end
  end
end
