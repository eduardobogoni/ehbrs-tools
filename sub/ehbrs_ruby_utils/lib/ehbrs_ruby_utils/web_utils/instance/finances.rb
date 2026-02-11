# frozen_string_literal: true

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::EacRailsBase0::Instances::Base
      class Finances
        require_sub __FILE__
        enable_simple_cache
        common_constructor :instance

        private

        def bills_uncached
          ::EhbrsRubyUtils::WebUtils::Instance::Finances::Bills.new(self)
        end
      end
    end
  end
end
