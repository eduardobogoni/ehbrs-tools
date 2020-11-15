# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class WebUtils < ::EacRubyUtils::Console::DocoptRunner
      class Videos
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'Ferramentas de vídeos para EHB/RS Utils.'
          subcommands
        end
      end
    end
  end
end
