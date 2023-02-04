# frozen_string_literal: true

require 'eac_rest/api'
require 'eac_ruby_utils/core_ext'
require 'avm/instances/base'

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::Instances::Base
      class HttpRequest
        enable_method_class
        enable_simple_cache
        common_constructor :instance, :resource_url_suffix, :source_options, default: [{}]

        # @return [EacRest::Response]
        def result
          r = request.response
          ::Struct.new(:status, :body).new(r.status, r.body_str)
        end

        private

        # @return [::Struct.new(:verb, :body_data, :headers)]
        def options_uncached
          options = source_options.to_options_consumer
          verb = options.consume(:method, :get).to_sym
          body_data = options.consume(:body)
          headers = options.consume(:header)
          options.validate
          ::Struct.new(:verb, :body_data, :headers).new(verb, body_data, headers)
        end

        # @return [EacRest::Request]
        def request
          instance.api.request(resource_url_suffix).verb(options.verb).headers(options.headers)
            .body_data(options.body_data)
        end
      end
    end
  end
end
