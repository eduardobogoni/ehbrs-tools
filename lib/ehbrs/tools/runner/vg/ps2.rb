# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'

module Ehbrs
  module Tools
    class Runner
      class Vg
        class Ps2
          runner_with :help, :subcommands do
            subcommands
          end

          require_sub __FILE__
        end
      end
    end
  end
end
