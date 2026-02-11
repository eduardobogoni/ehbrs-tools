# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Music
        runner_with :help, :subcommands do
          desc 'Ferramentas para músicas.'
          subcommands
        end
      end
    end
  end
end
