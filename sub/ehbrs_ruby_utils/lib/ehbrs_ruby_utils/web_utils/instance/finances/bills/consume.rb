# frozen_string_literal: true

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::EacRailsBase0::Instances::Base
      class Finances
        class Bills
          class Consume
            common_constructor(:bills)
            delegate :instance, :pending_directory, :registered_directory, to: :bills

            def perform
              bills.pending_directory.glob('**/*').each do |path|
                next unless path.file?

                ::EhbrsRubyUtils::WebUtils::Instance::Finances::Bills::Consume::File.new(self, path)
              end
            end
          end
        end
      end
    end
  end
end
