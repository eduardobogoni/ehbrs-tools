# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_cli/speaker'
require 'eac_cli/speaker/input_blocked'
require 'eac_config/node'
require 'eac_fs/contexts'
require 'eac_ruby_utils/speaker'

module EacRubyBase0
  module Runner
    module Prepend
      def run
        if parsed.version?
          show_version
        else
          run_with_subcommand
        end
      end

      def run_run
        on_context { super }
      end
    end
  end
end
