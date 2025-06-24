# frozen_string_literal: true

module EhbrsRubyUtils
  module CookingBook
    class Project
      RECIPES_ROOT_SUBPATH = 'recipes'

      enable_simple_cache
      common_constructor :root do
        self.root = root.to_pathname
      end

      delegate :to_s, to: :root

      private

      def recipes_root_uncached
        root.join(RECIPES_ROOT_SUBPATH)
      end

      def recipes_uncached
        ::Dir.glob(File.join('**', '*.{yml,yaml}'), base: recipes_root.to_path).map do |subpath|
          ::EhbrsRubyUtils::CookingBook::Recipe.from_file(recipes_root.join(subpath))
        end
      end
    end
  end
end
