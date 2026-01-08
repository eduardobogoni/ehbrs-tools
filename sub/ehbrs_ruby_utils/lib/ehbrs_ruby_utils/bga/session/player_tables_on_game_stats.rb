# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      class PlayerTablesOnGameStats
        include ::EhbrsRubyUtils::Bga::Urls

        enable_method_class
        enable_simple_cache
        common_constructor :session, :player_id, :until_table_id, default: [nil] do
          self.until_table_id = until_table_id.if_present(&:to_i)
        end

        SEE_MORE_BUTTON_ID = 'see_more_tables'

        def result
          navigate_to_page
          loop do
            return result_data unless more?
          end
        end

        # @return [Addressable::URI]
        def url
          player_game_stats_url(player_id)
        end

        private

        # @return [Array<Hash>]
        def current_data_uncached
          ::EhbrsRubyUtils::Bga::Parsers::GameStats.from_content(session.current_source).data
        end

        # @return [Array<Hash>]
        def new_current_data
          reset_cache(:current_data)
          current_data
        end

        def navigate_to_page
          session.navigate.to url
        end

        # @return [Boolean]
        def more?
          !(table_id_found? || list_end_reached?)
        end

        # @return [Boolean]
        def list_end_reached?
          previous_count = current_data.count
          result = nil
          session.on_skip_trophies { session.wait_for_click(id: SEE_MORE_BUTTON_ID) }
          session.wait.until do
            result = list_end_reached_non_waiting(previous_count)
            !result.nil?
          end
          result
        end

        # @param previous_count [Integer]
        # @return [Boolean, nil]
        def list_end_reached_non_waiting(previous_count) # rubocop:disable Naming/PredicateMethod
          if session.message_info.present?
            true
          elsif new_current_data.count != previous_count
            false
          end
        end

        # @return [Array<Hash>]
        def result_data
          until_table_id.if_present(current_data) do |v|
            r = []
            current_data.each do |d|
              break if d.fetch(:id) == v

              r << d
            end
            r
          end
        end

        # @return [Boolean]
        def table_id_found?
          until_table_id.if_present(false) do |v|
            current_data.any? { |d| d.fetch(:id) == v }
          end
        end
      end
    end
  end
end
