# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    module Parsers
      class Table < ::Aranha::Parsers::Html::Item
        require_sub __FILE__

        GAME_IMAGE_URL_PARSER = %r{/gamemedia/([^/]+)/box/}.to_parser { |m| m[1] }
        ITEM_XPATH = '/'
        PLAYERS_IDS = {
          'game_result' => ::EhbrsRubyUtils::Bga::Parsers::Table::EndedPlayers,
          'players_at_table' => ::EhbrsRubyUtils::Bga::Parsers::Table::ActivePlayers
        }.freeze
        PLAYERS_IDS_XPATH = PLAYERS_IDS.keys.map { |id| "@id = \"#{id}\"" }.join(' or ')
        PLAYERS_XPATH = ".//*[(#{PLAYERS_IDS_XPATH}) and count(./*) > 0]"

        field :game_code, :string, '//meta[@property="og:image"]/@content'
        field :game_name, :string, './/*[@id = "table_name"]/text()'
        field :creation_time, :string, './/*[@id = "creationtime"]/text()'
        field :estimated_duration, :string, './/*[@id = "estimated_duration"]/text()'
        field :options, :node, './/*[@id = "gameoptions"]'
        field :players, :node, PLAYERS_XPATH
        field :game_conceded, :node, './/*[@id = "game_conceded" and @style="display: block;"]'

        def item_xpath
          ITEM_XPATH
        end

        def data
          r = super
          %i[creation_time game_code game_conceded options players].each do |key|
            r[key] = send("process_#{key}", r.fetch(key))
          end
          r
        end

        private

        def process_creation_time(creation_time)
          creation_time.gsub('Criado:', '').strip
        end

        # @param node [String]
        # @return [String]
        def process_game_code(image_url)
          GAME_IMAGE_URL_PARSER.parse!(image_url)
        end

        # @param node [Nokogiri::XML::Element]
        # @return [Boolean]
        def process_game_conceded(node) # rubocop:disable Naming/PredicateMethod
          node.present?
        end

        # @param node [Nokogiri::XML::Element]
        # @return [Hash]
        def process_options(node)
          ::EhbrsRubyUtils::Bga::Parsers::Table::Options.from_node(node).data
        end

        # @param node [Nokogiri::XML::Element]
        # @return [Hash]
        def process_players(node)
          process_players_parser(node).from_node(node).data
        end

        # @param node [Nokogiri::XML::Element]
        # @return [Class]
        def process_players_parser(node)
          PLAYERS_IDS.fetch(node.attribute('id').value)
        end
      end
    end
  end
end
