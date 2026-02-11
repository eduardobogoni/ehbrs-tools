# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      include ::EacRubyBase0::Runner

      runner_definition do
        desc 'Tools for EHB/RS.'
      end

      delegate :application, to: :'::Ehbrs::Tools'

      def extra_available_subcommands
        {
          'avm' => ::Avm::Tools::Runner
        }
      end
    end
  end
end
