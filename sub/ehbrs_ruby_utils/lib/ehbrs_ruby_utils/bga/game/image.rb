# frozen_string_literal: true

require 'eac_fs/core_ext'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Game
      class Image
        common_constructor :game, :suffix

        IMAGE_URL_PREFIX = 'https://x.boardgamearena.net/data/gamemedia/'

        # @return [String]
        def fs_object_id
          [game.code, suffix].map(&:parameterize)
        end

        # @param suffix [String]
        # @return [Pathname]
        def local_path
          download_to_cache unless fs_cache.stored?
          fs_cache.content_path.to_pathname
        end

        # @return [Addressable::URI]
        def url
          "#{IMAGE_URL_PREFIX}#{game.code}#{suffix}".to_uri
        end

        private

        # @return [void]
        def download_to_cache
          fs_cache.send(:assert_directory_on_path)
          ::EacEnvs::Http::Request.new.url(url).response.write_body(fs_cache.content_path)
        end
      end
    end
  end
end
