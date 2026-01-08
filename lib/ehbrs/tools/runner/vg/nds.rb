# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Vg
        class Nds
          runner_with :help, :subcommands do
            subcommands
          end

          require_sub __FILE__
        end
      end
    end
  end
end
