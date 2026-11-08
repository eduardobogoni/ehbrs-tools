# frozen_string_literal: true

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::EacRailsBase0::Instances::Base
      class HttpRequest
        enable_method_class
        enable_memoized
        common_constructor :instance, :resource_url_suffix, :source_options, default: [{}]

        # @return [EacRest::Response]
        def result
          r = request.response
          ::EhbrsRubyUtils::WebUtils::RequestError.raise_if_error(r)
          ::Struct.new(:status, :body).new(r.status, ::JSON.parse(r.body_str))
        end

        private

        # @return [::Struct.new(:verb, :body_data, :headers, :timeout)]
        memoize def options
          options = source_options.to_options_consumer
          verb = options.consume(:method, :get).to_sym
          body_data = options.consume(:body)
          headers = options.consume(:header)
          timeout = options.consume(:timeout)
          options.validate
          ::Struct.new(:verb, :body_data, :headers, :timeout)
            .new(verb, body_data, headers, timeout)
        end

        # @return [EacRest::Request]
        def request
          %i[verb headers body_data timeout]
            .inject(instance.api.request(resource_url_suffix)) { |a, e| a.send(e, options.send(e)) }
        end
      end
    end
  end
end
