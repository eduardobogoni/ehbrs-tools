# frozen_string_literal: true

require 'eac_cli/core_ext'

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
