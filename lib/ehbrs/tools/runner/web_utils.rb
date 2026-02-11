# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        runner_with :help, :subcommands do
          desc 'Ferramentas para EHB/RS Utils.'
          pos_arg :instance_id
          subcommands
        end

        private

        def instance_uncached
          ::EhbrsRubyUtils::WebUtils::Instance.by_id(parsed.instance_id)
        end
      end
    end
  end
end
