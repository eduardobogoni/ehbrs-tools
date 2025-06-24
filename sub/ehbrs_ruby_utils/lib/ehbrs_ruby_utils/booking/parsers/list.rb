# frozen_string_literal: true

module EhbrsRubyUtils
  module Booking
    module Parsers
      class List < ::Aranha::Parsers::Html::ItemList
        class << self
          def testid_xpath(value, *suffixes)
            ([".//*[@data-testid='#{value}']"] + suffixes).join('/')
          end
        end

        ITEMS_XPATH = '//*[@data-testid="property-card"]'

        field :name, :string, testid_xpath('title', 'text()')
        field :href, :string, testid_xpath('title-link', '@href')
        field :price, :float, testid_xpath('price-and-discounted-price', '/text()')
        field :tax, :float_optional, testid_xpath('taxes-and-charges', 'text()')
        field :address, :string, testid_xpath('address', 'text()')
        field :distance, :distance, testid_xpath('distance', 'text()')
        field :review_score, :float_optional, testid_xpath('review-score', 'div[1]/text()')
        field :review_count, :integer_comma_optional,
              testid_xpath('review-score', 'div[2]/div[2]/text()')
        field :unit_title, :string_recursive, testid_xpath('recommended-units',
                                                           '/*[@role="link"]')

        def data
          { accommodations: items_data, declared_count: declared_count }
        end

        # @return [Integer]
        def declared_count
          node_parser.integer_value(nokogiri, '//h1/text()')
        end

        def items_xpath
          ITEMS_XPATH
        end

        def node_parser
          r = super
          r.extend(NodeParserExtra)
          r
        end

        module NodeParserExtra
          DISTANCE_PARSER = /\A(\d+)(?:,(\d+))? (m|km)/.to_parser do |m|
            r = m[1].to_f + m[2].if_present(0) { |v| v.to_f / 10.pow(v.length) }
            r /= 1000 if m[3] == 'm'
            r
          end

          def distance_value(node, xpath)
            s = string_value(node, xpath)
            DISTANCE_PARSER.parse!(s)
          end
        end
      end
    end
  end
end
