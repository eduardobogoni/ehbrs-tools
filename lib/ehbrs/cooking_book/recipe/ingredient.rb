# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/cooking_book/recipe/measure'

module Ehbrs
  module CookingBook
    class Recipe
      class Ingredient
        class << self
          def build(label, value)
            new(label, ::Ehbrs::CookingBook::Recipe::Measure.build(value))
          end
        end

        enable_simple_cache
        common_constructor :name, :measure
      end
    end
  end
end
