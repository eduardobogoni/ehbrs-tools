# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class GameStatistics
      class WhatsappFormatter
        class PlayerTitle
          acts_as_instance_method
          common_constructor :formatter, :player

          # @return [String]
          def result
            username_by_tables || player.name
          end

          # @return [String, nil]
          def username_by_tables
            formatter.with_players_tables.lazy.map { |table| username_by_table(table) }
              .find(&:present?)
          end

          # @param table [EhbrsRubyUtils::Bga::Table]
          # @return [String, nil]
          def username_by_table(table)
            table.player_by_id(player.id).if_present(&:name)
          end
        end
      end
    end
  end
end
