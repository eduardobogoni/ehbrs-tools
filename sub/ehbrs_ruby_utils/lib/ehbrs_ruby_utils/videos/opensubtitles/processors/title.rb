# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    module Opensubtitles
      module Processors
        class Title < ::Aranha::DefaultProcessor
          enable_simple_cache
          enable_speaker

          def perform
            infov 'Episodes', episodes.count
            episodes.each(&:perform)
          end

          # @return [Array<EhbrsRubyUtils::Videos::Opensubtitles::Processors::Subtitle>]
          def subtitles
            episodes.flat_map(&:subtitles)
          end

          private

          def episode_uri(episode_data)
            source_uri + episode_data.fetch(:href)
          end

          def episodes_uncached
            data.fetch(:episodes).map do |episode_data|
              ::EhbrsRubyUtils::Videos::Opensubtitles::Processors::Episode
                .new(episode_uri(episode_data), extra_data)
            end
          end
        end
      end
    end
  end
end
