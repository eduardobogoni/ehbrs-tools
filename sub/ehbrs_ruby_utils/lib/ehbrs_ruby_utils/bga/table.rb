# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/game'
require 'ehbrs_ruby_utils/bga/parsers/table'
require 'ehbrs_ruby_utils/bga/parsers/table/options'
require 'ehbrs_ruby_utils/bga/urls'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      include ::EhbrsRubyUtils::Bga::Urls
      enable_simple_cache
      common_constructor :data

      SET_ITEMS = %i[options players].freeze

      ([:id] + ::EhbrsRubyUtils::Bga::Parsers::Table.fields.map(&:name) - SET_ITEMS)
        .each do |field|
        define_method field do
          data.fetch(field)
        end
      end

      # @return [Boolean]
      def game_conceded?
        game_conceded
      end

      # @return [Addressable::URI]
      def url
        table_url(id)
      end

      private

      # @return [EhbrsRubyUtils::Bga::Game]
      def game_uncached
        ::EhbrsRubyUtils::Bga::Game.new(game_code)
      end

      SET_ITEMS.each do |item|
        define_method "#{item}_uncached" do
          data.fetch(item).map do |item_data|
            self.class.const_get(item.to_s.singularize.camelize).new(self, item_data)
          end
        end
      end

      require_sub __FILE__
    end
  end
end
