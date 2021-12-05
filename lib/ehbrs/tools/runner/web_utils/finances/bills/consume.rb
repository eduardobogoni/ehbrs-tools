# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'
require 'json'
require 'yaml'

module Ehbrs
  module Tools
    class Runner
      class WebUtils
        class Finances
          class Bills
            class Consume
              runner_with :help do
                desc 'Consome faturas.'
                bool_opt '-c', '--confirm', 'Confirma as mudanças'
              end

              # include ::Fs::CheckDirectoryOrFile

              def run
                start_banner
                consume.perform
              end

              private

              def consume_uncached
                runner_context.call(:instance).finances.bills.consume
              end

              def start_banner
                infov 'Instance', consume.instance
                infov 'Pending directory', consume.pending_directory
                infov 'Registered directory', consume.registered_directory
              end
            end
          end
        end
      end
    end
  end
end
