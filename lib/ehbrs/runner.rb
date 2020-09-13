# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'ehbrs/tools/version'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    require_sub __FILE__
    include ::EacCli::DefaultRunner

    runner_definition do
      desc 'Tools for EHB/RS.'
      subcommands
      alt do
        bool_opt '-V', '--version', 'Show version.'
      end
    end

    def run
      if options.fetch('--version')
        out(::Ehbrs::Tools::VERSION + "\n")
      else
        run_with_subcommand
      end
    end
  end
end
