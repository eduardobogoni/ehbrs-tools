# frozen_string_literal: true

require 'avm/eac_rails_base0/instances/base'
require 'avm/result'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::EacRailsBase0::Instances::Base
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
                response
                move_to_registered
              rescue ::EhbrsRubyUtils::WebUtils::RequestError
                warn("  * Retornou com status de erro:\n\n#{response.body}")
              end

              def move_to_registered
                ::FileUtils.mkdir_p(::File.dirname(target_path))
                ::File.rename(path, target_path)
                infom 'Moved to registered'
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
            end
          end
        end
      end
    end
  end
end
