# frozen_string_literal: true

require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class GameStats < ::Aranha::Parsers::Html::ItemList
        class Players < ::Aranha::Parsers::Html::ItemList
          ITEMS_XPATH = '//div[@class = "simple-score-entry"]'

          field :rank, :integer_optional, './div[@class = "rank"]'
          field :id, :integer, './div[@class = "name"]/a/@href'
          field :name, :string, './div[@class = "name"]/a/text()'
          field :score, :integer_optional, './div[@class = "score"]'

          def items_xpath
            ITEMS_XPATH
          end
        end
      end
    end
  end
end
