# frozen_string_literal: true

require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class GameStats < ::Aranha::Parsers::Html::ItemList
        ITEMS_XPATH = '//table[@id = "gamelist_inner"]/tr'

        field :game_name, :string, './td[1]/a[1]/text()'
        field :table_name, :string, './td[1]/a[2]/text()'
        field :time_string, :string, './td[2]/div[1]/text()'
        field :leave_penalty, :integer, './td[4]/span[1]/text()'
        field :rank_increment, :integer, './td[4]/span[2]/text()'
        field :rank_after, :integer, './td[4]//*[@class = "gamerank_value"]/text()'
        field :players, :node, './td[3]'

        def items_xpath
          ITEMS_XPATH
        end

        def item_data(item)
          r = super
          r[:id] = table_name_to_id(r.delete(:table_name))
          r[:players] = players_data(r.delete(:players))
          r
        end

        private

        def players_data(players_node)
          ::EhbrsRubyUtils::Bga::Parsers::GameStats::Players.from_node(
            players_node
          ).data
        end

        # @param name [String]
        # @return [Integer]
        def table_name_to_id(name)
          name.gsub(/\A\#/, '').to_i
        end

        require_sub __FILE__
      end
    end
  end
end
