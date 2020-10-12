# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/instances/base'
require 'httpclient'

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::Instances::Base
      def root_url
        read_entry(:url)
      end

      def resource_url(resource_url_suffix)
        root_url + '/' + resource_url_suffix.gsub(%r{\A/+}, '')
      end

      def http_request(resource_url_suffix, options = {})
        method = options.delete(:method) || 'get'
        url = resource_url(resource_url_suffix)
        http_client.request(method, url, options)
      end

      def http_client_uncached
        client = HTTPClient.new
        client.force_basic_auth = true
        client.set_basic_auth(root_url, read_entry(:admin_username), read_entry(:admin_password))
        client
      end
    end
  end
end
