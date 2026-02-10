# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Table
      include ::EhbrsRubyUtils::Bga::Urls

      enable_simple_cache
      common_constructor :data

      GAME_MODE_KEY = 'Modo de Jogo'
      GAME_MODE_FRIENDLY_VALUE = 'Modo Amigável'
      GAME_MODE_NORMAL_VALUE = 'Modo Normal'
      SET_ITEMS = %i[options players].freeze

      ([:id] + ::EhbrsRubyUtils::Bga::Parsers::Table.fields.map(&:name) - SET_ITEMS)
        .each do |field|
          define_method field do
            data.fetch(field)
          end
      end

      # @return [Boolean]
      def friendly?
        value = option_value(GAME_MODE_KEY)
        return true if value == GAME_MODE_FRIENDLY_VALUE
        return false if value == GAME_MODE_NORMAL_VALUE

        raise "Unknown \"#{GAME_MODE_KEY}\" value: \"#{value}\""
      end

      # @return [Boolean]
      def game_conceded?
        game_conceded
      end

      # @param key [String]
      # @return [String, nil]
      def option_value(label)
        options.find { |o| o.label == label }.if_present(&:value)
      end

      # @param id [Integer]
      # @return [EhbrsRubyUtils::Bga::Table::Player, nil]
      def player_by_id(id)
        players.find { |p| p.id.to_s == id.to_s }
      end

      # @return [Addressable::URI]
      def url
        table_url(id)
      end

      private

      # @return [EhbrsRubyUtils::Bga::Game]
      def game_uncached
        ::EhbrsRubyUtils::Bga::Game.new(game_code, game_name)
      end

      SET_ITEMS.each do |item|
        define_method "#{item}_uncached" do
          data.fetch(item).map do |item_data|
            self.class.const_get(item.to_s.singularize.camelize).new(self, item_data)
          end
        end
      end
    end
  end
end
