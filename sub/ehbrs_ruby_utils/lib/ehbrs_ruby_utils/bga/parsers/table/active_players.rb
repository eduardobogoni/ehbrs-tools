# frozen_string_literal: true

require 'dentaku'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class Table < ::Aranha::Parsers::Html::Item
        class ActivePlayers < ::Aranha::Parsers::Html::ItemList
          ITEMS_XPATH = '//div[starts-with(@id, "active_player_")]'

          field :id, :integer, './@id'
          field :name, :string, './/*[contains(@class, "active_player_fullname")]'

          def items_xpath
            ITEMS_XPATH
          end
        end
      end
    end
  end
end
