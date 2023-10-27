# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Base
          acts_as_abstract :players_title, :root_items_title, :title_icon
          enable_simple_cache
          common_constructor :table

          PLAYERS_EXTRA = ''
          ROOT_ITENS = {
            'Jogo' => :game_name,
            'Criada em' => :creation_time,
            'Duração' => :estimated_duration,
            'Endereço' => :url
          }.freeze
          SECTION_SEPARATOR = "\n\n"

          # @return [Pathname]
          def image_local_path
            table.game.box_large_image.local_path
          end

          def to_s
            [root_items_to_s, players_to_s, options_to_s].map(&:strip).join(SECTION_SEPARATOR)
          end

          def root_items_to_s
            title_to_s(root_items_title) + ROOT_ITENS.map { |k, v| "*#{k}*: #{table.send(v)}" }
                                             .join("\n")
          end

          def options_to_s
            title_to_s('Opções') + options.join("\n")
          end

          # @return [String]
          def players_extra
            PLAYERS_EXTRA
          end

          # @return [String]
          def players_to_s
            title_to_s(players_title) + players_extra + players.join("\n")
          end

          def title_to_s(title)
            "*#{[title_icon, title, title_icon].join(' ')}*\n\n"
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
