# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/cooking_book/recipe'

module Ehbrs
  module CookingBook
    class Project
      enable_simple_cache
      common_constructor :root do
        self.root = root.to_pathname
      end

      delegate :to_s, to: :root

      private

      def recipes_uncached
        ::Dir.glob(File.join('**', '*.{yml,yaml}'), base: root.to_path).map do |subpath|
          ::Ehbrs::CookingBook::Recipe.from_file(root.join(subpath))
        end
      end
    end
  end
end
