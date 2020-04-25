# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Videos < ::EacRubyUtils::Console::DocoptRunner
        require_sub __FILE__

        DOC = <<~DOCOPT
          Video tools for EHB/RS.

          Usage:
            __PROGRAM__ [options] __SUBCOMMANDS__
            __PROGRAM__ -h | --help

          Options:
            -h --help             Show this screen.
        DOCOPT
      end
    end
  end
end