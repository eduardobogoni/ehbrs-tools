# frozen_string_literal: true

require 'dentaku'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class Table < ::Aranha::Parsers::Html::Item
        class EndedPlayers < ::Aranha::Parsers::Html::ItemList
          ITEMS_XPATH = '//div[starts-with(@id, "score_entry_")]'
          RANK_VALUES = { vencedor: 1, perdedor: 2 }.freeze

          field :rank, :string, './div[@class = "rank"]'
          field :id, :integer, './div[@class = "name"]/a/@href'
          field :name, :string, './div[@class = "name"]/a/text()'
          field :score, :integer_optional, './div[@class = "score"]'
          field :elo_increment, :string, './/*[starts-with(@id, "winpoints_value_")]/text()'
          field :elo_reached, :integer, './/*[@class = "gamerank_value"]/text()'
          field :penalty_clock, :boolean,
                './/*[@class = "clockpenalty" and @style = "display: inline;"]'
          field :penalty_leave, :boolean,
                './/*[@class = "leavepenalty" and @style = "display: inline;"]'

          def items_xpath
            ITEMS_XPATH
          end

          def item_data(data)
            %i[elo_increment rank].inject(data) do |a, e|
              a.merge(e => send("process_#{e}", data.fetch(e)))
            end
          end

          # @return [Integer, nil]
          def process_elo_increment(expression)
            return nil if expression.blank?

            ::Dentaku::Calculator.new.evaluate(expression.gsub(/\A\+/, '')).to_i
          end

          # @param value [String]
          # @return [Integer]
          def process_rank(source)
            RANK_VALUES[source.downcase.to_sym] || source.to_i
          end
        end
      end
    end
  end
end
