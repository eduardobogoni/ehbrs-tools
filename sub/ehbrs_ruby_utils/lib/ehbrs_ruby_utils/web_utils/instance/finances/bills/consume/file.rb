# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/result'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::Instances::Base
      class Finances
        class Bills
          class Consume
            class File
              enable_speaker
              enable_simple_cache
              common_constructor(:bills, :path) { perform }
              delegate :instance, to: :bills

              protected

              def perform
                infov 'Relative path', relative_path
                process_response
              end

              def relative_path
                path.relative_path_from(bills.pending_directory.to_path)
              end

              def process_response
                if response_status_result.success?
                  move_to_registered
                else
                  warn("  * Retornou com status de erro:\n\n#{response.body}")
                end
                infov '  * Response status', response_status_result.label
              end

              def move_to_registered
                ::FileUtils.mkdir_p(::File.dirname(target_path))
                ::File.rename(path, target_path)
              end

              def target_path
                ::File.join(bills.registered_directory, relative_path)
              end

              def response_uncached
                bills.instance.http_request(
                  '/finances/file_imports',
                  method: :post,
                  body: {
                    'record[file]' => ::File.new(path)
                  },
                  header: {
                    'Accept' => 'application/json'
                  }
                )
              end

              def response_status_result
                ::Avm::Result.success_or_error(
                  response.status.to_s.match?(/\A2\d{2}\z/),
                  response.status
                )
              end
            end
          end
        end
      end
    end
  end
end
