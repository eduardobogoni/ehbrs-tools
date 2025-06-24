# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      class PlayerTablesOnGameInProgress
        include ::EhbrsRubyUtils::Bga::Urls
        enable_method_class
        enable_simple_cache
        common_constructor :session, :player_id

        WAIT_FOR_RESULT_SECONDS = 60

        def result
          navigate_to_page
          result_data
        end

        # @return [Addressable::URI]
        def url
          player_game_in_progress_url(player_id)
        end

        private

        def current_data
          ::EhbrsRubyUtils::Bga::Parsers::GameInProgress.from_content(session.current_source).data
        end

        # @return [Array<Hash>]
        def result_data
          cr = nil
          session.wait(WAIT_FOR_RESULT_SECONDS).until do
            scroll_down
            cr = current_data
            cr.fetch(:tables).count == cr.fetch(:table_count)
          end
          cr.fetch(:tables)
        end

        def navigate_to_page
          session.navigate.to url
        end

        def scroll_down
          session.scroll_down_by(90)
        end
      end
    end
  end
end
