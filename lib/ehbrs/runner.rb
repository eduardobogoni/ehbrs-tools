# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'ehbrs/tools/version'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    require_sub __FILE__
    enable_console_speaker

    DOC = <<~DOCOPT
      Tools for EHB/RS.

      Usage:
        __PROGRAM__ [options] __SUBCOMMANDS__
        __PROGRAM__ --version
        __PROGRAM__ -h | --help

      Options:
        -h --help             Show this screen.
        -V --version          Show version.
    DOCOPT

    def run
      if options.fetch('--version')
        out(::Ehbrs::Tools::VERSION + "\n")
      else
        run_with_subcommand
      end
    end
  end
end
