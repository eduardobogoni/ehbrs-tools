# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Ending < ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters::Base
          PLAYERS_TITLE = 'Resultado'
          ROOT_ITEMS_TITLE = 'Mesa terminada'
          TITLE_ICON = 0x1F3C6.chr(::Encoding::UTF_8)

          # @return [String]
          def game_conceded_to_s
            table.game_conceded? ? "*Derrota admitida*\n\n" : ''
          end

          # @return [String]
          def players_extra
            game_conceded_to_s
          end

          # @return [String]
          def players_title
            PLAYERS_TITLE
          end

          # @return [String]
          def root_items_title
            ROOT_ITEMS_TITLE
          end

          # @return [String]
          def title_icon
            TITLE_ICON
          end

          require_sub __FILE__, require_mode: :kernel
        end
      end
    end
  end
end
