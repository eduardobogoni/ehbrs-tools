# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Subtitles
          runner_with :help, :subcommands do
            desc 'Ferramentas para seriados.'
            subcommands
          end

          require_sub __FILE__
        end
      end
    end
  end
end
