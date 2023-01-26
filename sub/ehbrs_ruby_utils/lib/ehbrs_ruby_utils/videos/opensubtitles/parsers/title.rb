# frozen_string_literal: true

require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    module Opensubtitles
      module Parsers
        class Title < ::Aranha::Parsers::Html::ItemList
          ITEMS_XPATH = '//table[@id = "search_results"]/tbody/tr[@itemprop = "episode"]'

          field :href, :string, './/a[@itemprop = "url"]/@href'

          def items_xpath
            ITEMS_XPATH
          end

          def data
            { episodes: items_data }
          end
        end
      end
    end
  end
end
