# frozen_string_literal: true

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::EacRailsBase0::Instances::Base
      class Finances
        class Bills
          require_sub __FILE__
          common_constructor :finances
          delegate :instance, to: :finances

          # @return [Pathname]
          def bills_directory(suffix)
            instance.read_entry('finances.bills.directory').to_pathname.join(suffix)
          end

          # @return [EhbrsRubyUtils::WebUtils::Instance::Finances::Bills::Consume]
          def consume
            ::EhbrsRubyUtils::WebUtils::Instance::Finances::Bills::Consume.new(self)
          end

          # @return [Pathname]
          def pending_directory
            bills_directory('pending')
          end

          # @return [Pathname]
          def registered_directory
            bills_directory('registered')
          end
        end
      end
    end
  end
end
