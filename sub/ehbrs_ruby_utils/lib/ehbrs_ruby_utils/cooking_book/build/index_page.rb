# frozen_string_literal: true

module EhbrsRubyUtils
  module CookingBook
    class Build
      class IndexPage < ::EhbrsRubyUtils::CookingBook::Build::BasePage
        TITLE = 'Início'

        def initialize(parent)
          super(parent, nil)
        end

        def target_basename
          'index'
        end

        def title
          TITLE
        end
      end
    end
  end
end
