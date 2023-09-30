# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/yaml'
require 'ehbrs_ruby_utils/cooking_book/recipe/ingredient'

module EhbrsRubyUtils
  module CookingBook
    class Recipe
      class Part
        enable_simple_cache
        common_constructor :title, :source_data

        def notes
          source_data[:notes]
        end

        private

        def ingredients_uncached
          source_data.fetch(:ingredients).map do |label, value|
            ::EhbrsRubyUtils::CookingBook::Recipe::Ingredient.build(label, value)
          end
        end

        def steps_uncached
          source_data.fetch(:steps)
        end
      end
    end
  end
end
