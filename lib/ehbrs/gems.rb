# frozen_string_literal: true

require 'eac_ruby_gems_utils/gem'

module Ehbrs
  module Gems
    class << self
      enable_simple_cache

      def app_path
        ::Pathname.new('../..').expand_path(__dir__)
      end

      def vendor_gems_root
        app_path.join('vendor')
      end

      private

      def app_uncached
        ::EacRubyGemsUtils::Gem.new(app_path)
      end

      def all_uncached
        vendor_gems + [app]
      end

      def vendor_gems_uncached
        r = []
        vendor_gems_root.each_child.each do |child|
          r << ::EacRubyGemsUtils::Gem.new(child) if child.directory?
        end
        r
      end
    end
  end
end
