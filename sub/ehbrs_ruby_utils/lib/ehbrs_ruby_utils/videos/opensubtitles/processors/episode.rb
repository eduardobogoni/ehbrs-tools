# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    module Opensubtitles
      module Processors
        class Episode < ::Aranha::DefaultProcessor
          enable_simple_cache
          enable_speaker

          def perform
            infov source_uri, subtitles.count
            subtitles.each(&:perform)
            next_page.if_present(&:perform)
          end

          private

          def next_page_uncached
            data.fetch(:next_page_href)
              .if_present { |v| self.class.new(source_uri + v, extra_data) }
          end

          def subtitle_uri(subtitle_data)
            source_uri + subtitle_data.fetch(:href)
          end

          def subtitles_uncached
            data.fetch(:subtitles).map do |subtitle_data|
              ::EhbrsRubyUtils::Videos::Opensubtitles::Processors::Subtitle.new(
                subtitle_uri(subtitle_data), extra_data
              )
            end + next_page.if_present([], &:subtitles)
          end
        end
      end
    end
  end
end
