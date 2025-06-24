# frozen_string_literal: true

module EhbrsRubyUtils
  module CookingBook
    class Recipe
      class Ingredient
        class << self
          def build(label, value)
            new(label, ::EhbrsRubyUtils::CookingBook::Recipe::Measure.build(value))
          end
        end

        enable_simple_cache
        common_constructor :name, :measure
      end
    end
  end
end
