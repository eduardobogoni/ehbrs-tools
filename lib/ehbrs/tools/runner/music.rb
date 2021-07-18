# frozen_string_literal: true

require 'eac_cli/core_ext'

module Ehbrs
  module Tools
    class Runner
      class Music
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Ferramentas para músicas.'
          subcommands
        end
      end
    end
  end
end
