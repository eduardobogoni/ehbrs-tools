# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/bga/whatsapp_formatter'

module EhbrsRubyUtils
  module Bga
    class GameStatistics
      class WhatsappFormatter
        include ::EhbrsRubyUtils::Bga::WhatsappFormatter

        ROOT_TITLE = 'Estatísticas'
        TITLE_ICON = 0x1F4CA.chr(::Encoding::UTF_8)

        enable_simple_cache
        common_constructor :game_statistics
        delegate :game, :friendly_tables_count, :normal_tables, :players, :until_table,
                 :with_players_tables, to: :game_statistics

        # @return [Hash]
        def root_content
          r = { 'Jogo' => game.name, 'Mesas normais' => normal_tables.count,
                'Mesas amigáveis' => friendly_tables_count }
          until_table.if_present { |v| r['Após mesa'] = v.url }
          r
        end

        # @return [Hash<String, String>] "title" => "content"
        def sections
          r = { ROOT_TITLE => root_content }
          players.each do |player|
            r[player_title(player)] = player_content(player)
          end
          r
        end

        # @return [String]
        def title_icon
          TITLE_ICON
        end

        private

        # @return [Array<Integer>]
        def ranks_uncached
          r = ::Set.new
          normal_tables.each do |table|
            table.players.each do |player|
              r.add(player.rank)
            end
          end
          r.sort
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
