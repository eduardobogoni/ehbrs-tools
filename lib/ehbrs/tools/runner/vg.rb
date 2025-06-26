# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Vg
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Ferramentas para video game.'
          subcommands
        end
      end
    end
  end
end
