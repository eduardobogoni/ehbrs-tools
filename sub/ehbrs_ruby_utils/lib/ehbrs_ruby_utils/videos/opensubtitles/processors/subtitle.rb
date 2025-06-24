# frozen_string_literal: true

require 'eac_fs/cached_download'

module EhbrsRubyUtils
  module Videos
    module Opensubtitles
      module Processors
        class Subtitle < ::Aranha::DefaultProcessor
          enable_simple_cache
          enable_speaker

          def perform
            infov '  * ', source_uri
            assert_download
          rescue ::RuntimeError => e
            error(e)
          end

          private

          def assert_download
            cached_download.assert
          end

          def cached_download_uncached
            ::EacFs::CachedDownload.new(source_uri, fs_cache)
          end

          def fs_object_id
            source_uri.to_s.parameterize
          end
        end
      end
    end
  end
end
