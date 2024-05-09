# frozen_string_literal: true

require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class GameInProgress < ::Aranha::Parsers::Html::ItemList
        DEFAULT_STATUS = 'asyncplay'
        ID_PARSER = /table=(\d+)/.to_parser { |m| m[1].to_i }
        ITEMS_XPATH = '//*[@id = "section-play"]//a[contains(@href, "table=")]'
        STATUS_CLASS_PATTERN = /\Agametable_status_(.+)\z/.freeze
        STATUS_CLASS_PARSER = STATUS_CLASS_PATTERN.to_parser { |m| m[1] }
        TABLE_COUNT_XPATH =
          '//*[@id = "section-play"]/h1/span[contains(@class, "font-normal")]/span/text()'

        field :href, :string, './@href'

        def data
          {
            table_count: table_count,
            tables: items_data
          }
        end

        def item_data(idd)
          { id: parse_id(idd.fetch(:href)), status: 'asyncplay' }
        end

        def items_xpath
          ITEMS_XPATH
        end

        # @param href [String]
        # @return [Integer]
        def parse_id(href)
          ID_PARSER.parse!(href)
        end

        # @return [Integer]
        def table_count
          nokogiri.at_xpath(TABLE_COUNT_XPATH).if_present(-1) { |v| v.text.to_i }
        end
      end
    end
  end
end
