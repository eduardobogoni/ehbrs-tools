# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Airbnb
        runner_with :help, :subcommands do
          desc 'Utilidades para o site airbnb.com.'
          subcommands
        end
      end
    end
  end
end
