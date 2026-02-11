# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Vg
        runner_with :help, :subcommands do
          desc 'Ferramentas para video game.'
          subcommands
        end
      end
    end
  end
end
