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
      SYSTEM_STACK_ERROR_FILE = 'system_stack_error'

      def run
        on_rescue_stack_overflow do
          if parsed.version?
            show_version
          else
            run_with_subcommand
          end
        end
      end

      def run_run
        on_context { super }
      end

      private

      def on_rescue_stack_overflow
        yield
      rescue ::SystemStackError => e
        SYSTEM_STACK_ERROR_FILE.to_pathname.write(e.backtrace.map { |v| "#{v}\n" }.join)
        raise e
      end
    end
  end
end
