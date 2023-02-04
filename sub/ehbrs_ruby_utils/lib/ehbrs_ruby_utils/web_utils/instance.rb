# frozen_string_literal: true

require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'
require 'avm/instances/base'

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::Instances::Base
      require_sub __FILE__, require_dependency: true

      # @return [EacRest::Api]
      def api
        ::EacRest::Api.new(root_url, read_entry(:admin_username), read_entry(:admin_password))
      end

      def finances
        @finances ||= ::EhbrsRubyUtils::WebUtils::Instance::Finances.new(self)
      end

      def root_url
        read_entry(::Avm::Instances::EntryKeys::WEB_URL)
      end
    end
  end
end
