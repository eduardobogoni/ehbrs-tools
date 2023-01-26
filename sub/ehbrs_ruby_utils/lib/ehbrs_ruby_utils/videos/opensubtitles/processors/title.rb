# frozen_string_literal: true

require 'aranha/default_processor'
require 'ehbrs_ruby_utils/videos/opensubtitles/parsers/title'
require 'ehbrs_ruby_utils/videos/opensubtitles/processors/episode'
require 'eac_ruby_utils/core_ext'

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
