# frozen_string_literal: true

module EhbrsRubyUtils
  module Airbnb
    module Parsers
      class Page < ::Aranha::Parsers::Html::ItemList
        class << self
          # @param value [String]
          # @param suffixes [Enumerable<String>]
          # @return [String]
          def testid_xpath(value, *suffixes)
            ([".//*[@data-testid='#{value}']"] + suffixes).join('/')
          end
        end

        DECLARED_COUNT_XPATH = '//h1/span[1]/text()'
        ITEMS_XPATH = '//*[@data-xray-jira-component="Guest: Listing Cards"]/div'
        NEXT_PAGE_HREF_XPATH = '//a[@aria-label="Próximo"]/@href'
        REVIEW_STRUCT = ::Struct.new(:review_score, :review_count)
        TYPE_ADDRESS_STRUCT = ::Struct.new(:type, :address)
        REVIEW_PARSER = /\A(\S+)\s*\((\d+)\)\z/.to_parser do |m|
          {
            review_score: m[1].gsub(',', '.').to_f, review_count: m[2].to_i
          }
        end
        REVIEW_TEXTS_ZERO = ['Novo', ''].freeze

        field :name, :string, './/meta[@itemprop="name"]/@content'
        field :href, :string, './/meta[@itemprop="url"]/@content'
        field :type_address, :string, testid_xpath('listing-card-title', 'text()')
        field :review_text, :string,
              './/*[@inert="true"]/../span/span[@aria-hidden="true"]/text()'
        field :price1, :decimal_comma_optional,
              './/*[@style="--pricing-guest-primary-line-unit-price-text-decoration: none;"]'
        field :price2, :decimal_comma_optional,
              '(.//div[contains(@style, "--pricing-guest-display-price-alignment")]//button)[2]' \
              '/span[1]/text()'

        def data
          %i[accommodations declared_count next_page_href].inject({}) do |a, e|
            a.merge({ e => send(e) })
          end
        end

        # @return [Enumerable<Hash>]
        def accommodations
          items_data.map do |e|
            e.merge(parse_review(e.fetch(:review_text)))
              .merge(parse_type_address(e.fetch(:type_address)))
              .merge(price: build_price(e.fetch(:price1), e.fetch(:price2)))
          end
        end

        # @return [Integer]
        def declared_count
          node_parser.integer_optional_value(nokogiri, DECLARED_COUNT_XPATH)
        end

        # @return [String]
        def items_xpath
          ITEMS_XPATH
        end

        # @return [String]
        def next_page_href
          nokogiri.at_xpath(NEXT_PAGE_HREF_XPATH).if_present(&:text)
        end

        # @param prices [Enumerable<Float, nil>]
        # @return [Float]
        def build_price(*prices)
          prices.reject(&:blank?).min
        end

        # @param text [String]
        # @return [Hash]
        def parse_review(text)
          return REVIEW_STRUCT.new(0, 0).to_h if REVIEW_TEXTS_ZERO.include?(text)

          REVIEW_PARSER.parse!(text).to_h
        end

        # @param text [String]
        # @return [Hash]
        def parse_type_address(text)
          TYPE_ADDRESS_STRUCT.new(*text.split('⋅').map(&:strip)).to_h
        end
      end
    end
  end
end
