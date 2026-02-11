# frozen_string_literal: true

require 'nokogiri'

module UltimateLyrics
  class Provider
    class << self
      # @return [Array<UltimateLyrics::Provider>]
      def all
        @all ||= ::Nokogiri::XML(
          ::File.new(::File.join(__dir__, 'providers_data.xml'))
        ).xpath('/lyricproviders/provider').map { |node| new(node) }
      end

      # @return [UltimateLyrics::Provider]
      def by_name(name)
        by_attribute('name', name)
      end

      # @return [UltimateLyrics::Provider]
      def by_identifier(identifier)
        by_attribute('identifier', identifier)
      end

      # @return [UltimateLyrics::Provider]
      def by_attribute(attribute, value)
        all.find { |provider| provider.send(attribute) == value } ||
          raise("No provider with name \"#{value}\" (Available: " + # rubocop:disable Style/StringConcatenation
            all.map { |p| p.send(attrbute) }.join(', ') + ')')
      end
    end

    common_constructor :node

    def encoding
      node.attribute('charset').text
    end

    def extract_rules
      node.xpath('./extract').map do |v|
        ::UltimateLyrics::Provider::Rule.new(v)
      end
    end

    def exclude_rules
      node.xpath('./exclude').map do |v|
        ::UltimateLyrics::Provider::Rule.new(v)
      end
    end

    def identifier
      name.variableize
    end

    def invalid_indicators
      node.xpath('/invalidIndicator/@value').map(&:text)
    end

    # @return [String]
    def name
      node.attribute('name').text
    end

    def rules
      extract_rules + exclude_rules
    end

    # @return [String]
    def url
      node.attribute('url').text
    end

    # @return [Array<UltimateLyrics::Field>]
    def url_fields
      ::UltimateLyrics::Field.from_string(url)
    end

    def url_formats
      node.xpath('./urlFormat').map do |v|
        ::UltimateLyrics::Provider::UrlFormat.new(v)
      end
    end

    def title
      node.attribute('text').text
    end

    def to_s
      name
    end
  end
end
