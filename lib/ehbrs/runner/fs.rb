# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class Fs < ::EacRubyUtils::Console::DocoptRunner
      include ::EacCli::DefaultRunner
      require_sub __FILE__

      runner_definition do
        desc 'Ferramentas para o sistema de arquivos.'
        subcommands
      end
    end
  end
end
