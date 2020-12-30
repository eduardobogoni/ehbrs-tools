# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/cooking_book/build/base_page'

module Ehbrs
  module CookingBook
    class Build
      class IndexPage < ::Ehbrs::CookingBook::Build::BasePage
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
