# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    module Urls
      common_concern

      module InstanceMethods
        ROOT_URL = 'https://boardgamearena.com'

        # @param suffix [String]
        # @return [Addressable::URI]
        def build_url(suffix)
          root_url + suffix
        end

        # @para player_id [Integer]
        # @return [Addressable::URI]
        def player_game_in_progress_url(player_id)
          build_url("/gameinprogress?player=#{player_id}&all")
        end

        # @para player_id [Integer]
        # @return [Addressable::URI]
        def player_game_stats_url(player_id)
          build_url("/gamestats?player=#{player_id}")
        end

        # @return [Addressable::URI]
        def root_url
          ROOT_URL.to_uri
        end

        # @return [Addressable::URI]
        def table_url(table_id)
          build_url("/table?table=#{table_id}")
        end
      end

      extend InstanceMethods
    end
  end
end
