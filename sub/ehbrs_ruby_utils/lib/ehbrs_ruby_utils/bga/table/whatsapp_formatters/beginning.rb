# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Beginning < ::EhbrsRubyUtils::Bga::Table::WhatsappFormatters::Base
          PLAYERS_TITLE = 'Jogadores'
          ROOT_ITEMS_TITLE = 'Mesa iniciada'
          TITLE_ICON = 0x2694.chr(::Encoding::UTF_8)

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
