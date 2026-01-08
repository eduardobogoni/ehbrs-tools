# frozen_string_literal: true

module EhbrsRubyUtils
  module CookingBook
    class Build
      class RecipePage < ::EhbrsRubyUtils::CookingBook::Build::BasePage
        def target_basename
          title.variableize
        end

        def parts
          @parts ||= super.map { |e| Part.new(e) }
        end

        class Part < SimpleDelegator
          def content
            ::EhbrsRubyUtils::CookingBook::Build::RecipePage.erb_template('part.html.erb', self)
          end
        end
      end
    end
  end
end
