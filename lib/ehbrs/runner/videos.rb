# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Videos < ::EacRubyUtils::Console::DocoptRunner
      runner_with :output_file
      require_sub __FILE__

      runner_definition do
        desc 'Video tools for EHB/RS.'
        subcommands
      end
    end
  end
end
