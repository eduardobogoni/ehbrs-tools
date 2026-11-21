# frozen_string_literal: true

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::EacRailsBase0::Instances::Base
      VIDEOS_FILES_REPOSITORIES_URL_SUFFIX = '/videos/files_repositories/export'

      require_sub __FILE__, require_dependency: true

      # @return [EacRest::Api]
      def api
        ::EacRest::Api.new(root_url, read_entry(:admin_username), read_entry(:admin_password))
      end

      def finances
        @finances ||= ::EhbrsRubyUtils::WebUtils::Instance::Finances.new(self)
      end

      def root_url
        web_url
      end

      # @return [Array<Hash>]
      def videos_files_repositories
        http_request(VIDEOS_FILES_REPOSITORIES_URL_SUFFIX).body
      end
    end
  end
end
