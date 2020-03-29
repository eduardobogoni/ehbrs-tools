# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Ehbrs
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Vg < ::EacRubyUtils::Console::DocoptRunner
        require_sub __FILE__
        enable_console_speaker

        DOC = <<~DOCOPT
          Videogame tools.

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
