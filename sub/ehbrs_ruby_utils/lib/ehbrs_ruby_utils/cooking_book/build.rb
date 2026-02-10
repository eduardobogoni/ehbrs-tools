# frozen_string_literal: true

module EhbrsRubyUtils
  module CookingBook
    class Build
      enable_simple_cache
      enable_listable
      lists.add_symbol :option, :target_dir

      common_constructor :project, :options, default: [{}] do
        self.options = self.class.lists.option.hash_keys_validate!(options.symbolize_keys)
      end

      def run
        target_dir.clear
        index_page.build
        recipes_pages.each(&:build)
      end

      private

      def index_page_uncached
        ::EhbrsRubyUtils::CookingBook::Build::IndexPage.new(self)
      end

      def recipes_pages_uncached
        project.recipes.map do |recipe|
          ::EhbrsRubyUtils::CookingBook::Build::RecipePage.new(self, recipe)
        end
      end

      def target_dir_uncached
        ::EacRubyUtils::Fs::ClearableDirectory.new(options[OPTION_TARGET_DIR] || default_target_dir)
      end

      def default_target_dir
        project.root.join('dist')
      end
    end
  end
end
