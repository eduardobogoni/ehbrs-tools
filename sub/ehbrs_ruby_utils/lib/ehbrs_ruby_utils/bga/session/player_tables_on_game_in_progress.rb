# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/game_in_progress'
require 'ehbrs_ruby_utils/bga/urls'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      class PlayerTablesOnGameInProgress
        include ::EhbrsRubyUtils::Bga::Urls
        enable_method_class
        enable_simple_cache
        common_constructor :session, :player_id

        def result
          navigate_to_page
          result_data
        end

        # @return [Addressable::URI]
        def url
          player_game_in_progress_url(player_id)
        end

        private

        # @return [Array<Hash>]
        def result_data
          ::EhbrsRubyUtils::Bga::Parsers::GameInProgress.from_content(session.current_source).data
        end

        def navigate_to_page
          session.navigate.to url
        end
      end
    end
  end
end
