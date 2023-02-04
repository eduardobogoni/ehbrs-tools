# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module WebUtils
    class RequestError < ::RuntimeError
      class << self
        def raise_if_error(response)
          by_error(response).if_present { |v| raise v }
        end

        def by_error(response)
          return new(response, "status #{response.status}") unless
            response.status.to_s.match?(/\A2\d{2}\z/)

          data = ::JSON.parse(response.body_str)
          return nil unless data.is_a?(::Hash)

          errors = data['errors'] || {}
          return nil if errors.empty?

          new(response, "errors #{errors.pretty_inspect}")
        end
      end

      enable_simple_cache
      common_constructor :response, :message_suffix, super_args: -> { build_message }

      # @return [String]
      def build_message
        "Request for \"#{response.url}\" failed: #{message_suffix}\nBody file: #{body_file_path}"
      end

      private

      # @return [Pathname]
      def body_file_path_uncached
        r = ::EacRubyUtils::Fs::Temp.file(body_file_path_naming)
        r.write(response.body_str)
        r.to_path.to_pathname
      end

      def body_file_path_naming
        r = ['request_error']
        r << '.json' if response.status == 200
        r
      end
    end
  end
end
