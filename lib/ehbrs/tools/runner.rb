# frozen_string_literal: true

require 'avm/tools/runner'
require 'eac_ruby_base0/runner'
require 'ehbrs/tools/application'

module Ehbrs
  module Tools
    class Runner
      require_sub __FILE__
      include ::EacRubyBase0::Runner

      runner_definition do
        desc 'Tools for EHB/RS.'
      end

      def application
        ::Ehbrs::Tools.application
      end

      def extra_available_subcommands
        {
          'avm' => ::Avm::Tools::Runner
        }
      end
    end
  end
end
