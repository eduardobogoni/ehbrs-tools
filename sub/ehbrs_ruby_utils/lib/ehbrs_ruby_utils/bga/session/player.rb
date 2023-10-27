# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      class Player
        common_constructor :session, :player_id

        def tables
          session.player_tables_on_game_stats(player_id)
        end
      end
    end
  end
end
