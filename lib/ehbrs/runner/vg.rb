# frozen_string_literal: true

require 'eac_cli/core_ext'

module Ehbrs
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
