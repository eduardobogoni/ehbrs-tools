# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Video tools for EHB/RS.'
          subcommands
        end
      end
    end
  end
end
