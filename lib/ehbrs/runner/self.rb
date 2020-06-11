# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Self < ::EacRubyUtils::Console::DocoptRunner
      require_sub __FILE__
      include ::EacCli::DefaultRunner

      runner_definition do
        desc 'Self utilities'
        subcommands
      end
    end
  end
end
