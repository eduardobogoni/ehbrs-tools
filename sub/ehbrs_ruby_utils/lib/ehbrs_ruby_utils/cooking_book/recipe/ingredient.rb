# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/cooking_book/recipe/measure'

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
