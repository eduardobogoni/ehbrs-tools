# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Videos < ::EacRubyUtils::Console::DocoptRunner
      class Series
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Ferramentas para seriados.'
          subcommands
        end
      end
    end
  end
end
