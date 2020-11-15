# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'ehbrs_ruby_utils/web_utils/instance'

module Ehbrs
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    class WebUtils
      require_sub __FILE__

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
