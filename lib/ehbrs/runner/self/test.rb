# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'ehbrs/gems'
require 'eac_ruby_gems_utils/tests/multiple'

module Ehbrs
  class Runner
    class Self
      class Test
        runner_with :help do
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
