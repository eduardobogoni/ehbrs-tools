# frozen_string_literal: true

module Ehbrs
  module UserDirs
    class << self
      include ::EacRubyUtils::SimpleCache

      def application_id
        'ehbrs-tools'
      end

      private

      def user_home_dir_uncached
        ::EacFs::StorageTree.new(Dir.home)
      end

      def cache_uncached
        user_home_dir.child('.cache', application_id)
      end

      def config_uncached
        user_home_dir.child('.config', application_id)
      end

      def data_uncached
        user_home_dir.child('.local', 'share', application_id)
      end
    end
  end
end
