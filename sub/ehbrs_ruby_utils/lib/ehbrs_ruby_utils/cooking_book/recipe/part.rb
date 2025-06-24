# frozen_string_literal: true

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
