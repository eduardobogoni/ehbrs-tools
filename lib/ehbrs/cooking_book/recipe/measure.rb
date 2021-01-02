# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/yaml'
require 'ehbrs/cooking_book/recipe/ingredient'

module Ehbrs
  module CookingBook
    class Recipe
      class Measure
        FLOAT_PATTERN = /\d+(?:\.\d+)?/.freeze
        FRACTION_PATTERN = %r{(#{FLOAT_PATTERN})(?:\s*/\s*(#{FLOAT_PATTERN}))?}.freeze
        QUANTITY_UNIT_PATTERN = /\A#{FRACTION_PATTERN}(?:\s*(\S+))?\z/.freeze
        VARIABLE_PATTERN = /\A\~\z/.freeze
        VARIABLE_TEXT = 'a gosto'

        class << self
          def build(value)
            value = value.to_s.strip
            build_from_variable(value) || build_from_pattern(value) || build_unknown(value)
          end

          private

          def build_from_variable(value)
            VARIABLE_PATTERN.if_match(value, false) do
              new(nil, nil, nil)
            end
          end

          def build_from_pattern(value)
            QUANTITY_UNIT_PATTERN.if_match(value, false) do |m|
              new(m[1].if_present(&:to_f), m[2].if_present(&:to_f), m[3])
            end
          end

          def build_unknown(value)
            new(nil, nil, "unknown format: |#{value}|")
          end
        end

        common_constructor :numerator, :denominator, :unit

        def to_s
          return VARIABLE_TEXT if variable?

          "#{quantity_to_s} #{unit}"
        end

        def quantity_to_s
          numerator.to_s + (denominator.if_present('') { |v| "/ #{v}" })
        end

        def variable?
          numerator.blank?
        end
      end
    end
  end
end
