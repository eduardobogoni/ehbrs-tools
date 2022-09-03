# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/cooking_book/build/base_page'

module Ehbrs
  module CookingBook
    class Build
      class RecipePage < ::Ehbrs::CookingBook::Build::BasePage
        def target_basename
          title.variableize
        end

        def parts
          @parts ||= super.map { |e| Part.new(e) }
        end

        class Part < SimpleDelegator
          def content
            ::Ehbrs::CookingBook::Build::RecipePage.erb_template('part.html.erb', self)
          end
        end
      end
    end
  end
end
