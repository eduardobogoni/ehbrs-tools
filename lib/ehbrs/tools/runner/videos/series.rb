# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Series
          require_sub __FILE__

          runner_with :help, :subcommands do
            desc 'Ferramentas para seriados.'
            subcommands
          end
        end
      end
    end
  end
end
