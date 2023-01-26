# frozen_string_literal: true

require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    module Opensubtitles
      module Parsers
        class Episode < ::Aranha::Parsers::Html::ItemList
          ITEMS_XPATH = '//table[@id = "search_results"]/tbody/tr[starts-with(@id, "name")]'

          field :href, :string, './/a[contains(@href, "/subtitleserve/")]/@href'

          def items_xpath
            ITEMS_XPATH
          end

          def data
            { subtitles: items_data, next_page_href: next_page_href }
          end

          def next_page_href
            nokogiri.at_xpath('//*[@id = "pager"]//a[text() = ">>"]/@href').if_present(&:text)
          end
        end
      end
    end
  end
end
