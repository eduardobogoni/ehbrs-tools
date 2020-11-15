# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Google
      require_sub __FILE__

      runner_with :help, :subcommands do
        desc 'Utilidades Google.'
        subcommands
      end
    end
  end
end
