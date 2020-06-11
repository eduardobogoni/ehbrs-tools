# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'ehbrs/gems'
require 'eac_ruby_gems_utils/tests/multiple'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Self < ::EacRubyUtils::Console::DocoptRunner
      class Test < ::EacRubyUtils::Console::DocoptRunner
        require_sub __FILE__
        include ::EacCli::DefaultRunner

        runner_definition do
          desc 'Test core and local gems.'
        end

        def run
          fatal_error 'Some test did not pass' unless tests.ok?
        end

        def tests_uncached
          ::EacRubyGemsUtils::Tests::Multiple.new(::Ehbrs::Gems.all)
        end
      end
    end
  end
end