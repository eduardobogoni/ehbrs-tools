# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class GameStatistics
      class WhatsappFormatter
        class PlayerContent
          acts_as_instance_method
          common_constructor :formatter, :player

          # @return [Hash<String, String>]
          def result
            formatter.ranks.to_h do |rank|
              [rank_label(rank), rank_value(rank)]
            end
          end

          # @param rank [Integer]
          # @return [String]
          def rank_label(rank)
            "#{rank}º"
          end

          # @param rank [Integer]
          # @return [String]
          def rank_value(rank)
            count = 0
            formatter.normal_tables.each do |table|
              count += 1 if table.player_by_id(player.id).if_present(false) do |v|
                              v.rank == rank
                            end
            end
            "#{count} (#{rank_percent(count)}%)"
          end

          # @param count [Integer]
          # @return [String]
          def rank_percent(count)
            (count * 100 / formatter.normal_tables.count).round
          end
        end
      end
    end
  end
end
