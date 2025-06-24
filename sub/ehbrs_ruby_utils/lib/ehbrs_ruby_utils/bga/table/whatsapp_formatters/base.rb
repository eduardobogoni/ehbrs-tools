# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Base
          include ::EhbrsRubyUtils::Bga::WhatsappFormatter
          acts_as_abstract :players_title, :root_items_title
          enable_simple_cache
          common_constructor :table

          PLAYERS_EXTRA = ''
          ROOT_ITENS = {
            'Jogo' => :game_name,
            'Criada em' => :creation_time,
            'Duração' => :estimated_duration,
            'Endereço' => :url
          }.freeze

          delegate :game, to: :table

          # @return [Hash<String, String>] "title" => "content"
          def sections
            {
              root_items_title => root_items,
              players_title => players_to_s,
              'Opções' => options
            }
          end

          # @return [Hash]
          def root_items
            ROOT_ITENS.transform_values { |v| table.send(v) }
          end

          # @return [String]
          def players_extra
            PLAYERS_EXTRA
          end

          # @return [String]
          def players_to_s
            players_extra + players.join("\n")
          end

          def players
            table.players.map { |player| format_player(player) }
          end

          def options
            table.options.map { |player| format_option(player) }
          end

          require_sub __FILE__, require_mode: :kernel
        end
      end
    end
  end
end
