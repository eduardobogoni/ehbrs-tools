# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/tools/version'

module Ehbrs
  class Runner
    require_sub __FILE__

    runner_with :help, :subcommands do
      desc 'Tools for EHB/RS.'
      subcommands
      alt do
        bool_opt '-V', '--version', 'Show version.'
      end
    end

    def run
      if parsed[:version].present?
        out(::Ehbrs::Tools::VERSION + "\n")
      else
        run_with_subcommand
      end
    end
  end
end
