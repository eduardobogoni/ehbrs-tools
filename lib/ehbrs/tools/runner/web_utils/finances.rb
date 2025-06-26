# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Finances
          require_sub __FILE__

          runner_with :help, :subcommands do
            desc 'Finanças.'
            subcommands
          end
        end
      end
    end
  end
end
