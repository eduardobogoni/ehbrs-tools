# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Finances
          require_sub __FILE__

          runner_with :help, :subcommands do
            desc 'Finanças.'
            subcommands
          end
        end
      end
    end
  end
end
