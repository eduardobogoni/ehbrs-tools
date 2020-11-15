# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Vg
      require_sub __FILE__

      runner_with :help, :subcommands do
        desc 'Ferramentas para video game.'
        subcommands
      end
    end
  end
end
