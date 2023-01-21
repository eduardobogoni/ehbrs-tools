# frozen_string_literal: true

require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'
require 'avm/instances/base'

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::Instances::Base
      require_sub __FILE__

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

      # @param resource_url_suffix [String]
      # @param options [Hash]
      # @return [EacRest::Response]
      def http_request(resource_url_suffix, options = {})
        options = http_request_options(options)
        r = api.request(resource_url_suffix).verb(options.verb).headers(options.headers)
              .body_data(options.body_data).response
        ::Struct.new(:status, :body).new(r.status, r.body_str)
      end

      private

      # @return [::Struct.new(:verb, :body_data, :headers)]
      def http_request_options(options)
        options = options.to_options_consumer
        verb = options.consume(:method, :get).to_sym
        body_data = options.consume(:body)
        headers = options.consume(:header)
        options.validate
        ::Struct.new(:verb, :body_data, :headers).new(verb, body_data, headers)
      end
    end
  end
end
