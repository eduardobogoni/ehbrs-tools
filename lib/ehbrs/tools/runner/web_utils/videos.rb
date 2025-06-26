# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Videos
          require_sub __FILE__

          runner_with :help, :subcommands do
            desc 'Ferramentas de vídeos para EHB/RS Utils.'
            subcommands
          end
        end
      end
    end
  end
end
