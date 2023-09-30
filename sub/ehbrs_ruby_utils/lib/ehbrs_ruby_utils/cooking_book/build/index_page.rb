# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/cooking_book/build/base_page'

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
