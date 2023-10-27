# frozen_string_literal: true

require 'aranha/parsers/html/item'
require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class Table < ::Aranha::Parsers::Html::Item
        class Options < ::Aranha::Parsers::Html::ItemList
          ITEMS_XPATH = '//div[starts-with(@id, "gameoption_")' \
            ' and not(contains(@style, "none"))]'

          field :label, :string, './div[@class = "row-label"]/text()'
          field :value, :string, './div[@class = "row-value"]' \
            "//*[#{xpath_ends_with('@id', "'_displayed_value'")}]/text()"
          field :description, :string, './div[@class = "gameoption_description"]/text()'

          def items_xpath
            ITEMS_XPATH
          end

          def data
            super.reject { |item| item.fetch(:label).blank? }
          end
        end
      end
    end
  end
end
