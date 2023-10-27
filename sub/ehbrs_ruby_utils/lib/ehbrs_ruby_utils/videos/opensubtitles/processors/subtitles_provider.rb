# frozen_string_literal: true

require 'aranha/default_processor'
require 'ehbrs_ruby_utils/videos/opensubtitles/processors/episode'
require 'ehbrs_ruby_utils/videos/opensubtitles/processors/title'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Videos
    module Opensubtitles
      module Processors
        class SubtitlesProvider < ::Aranha::DefaultProcessor
          enable_simple_cache

          delegate :perform, :subtitles, to: :sub_processor

          # @return [Boolean]
          def episode?
            title_parser.data[:episodes].if_present(true, &:empty?)
          end

          private

          # @return [Class]
          def sub_processor_class
            if episode?
              ::EhbrsRubyUtils::Videos::Opensubtitles::Processors::Episode
            else
              ::EhbrsRubyUtils::Videos::Opensubtitles::Processors::Title
            end
          end

          # @return [EhbrsRubyUtils::Videos::Opensubtitles::Parsers::Episode]
          def episode_parser
            ::EhbrsRubyUtils::Videos::Opensubtitles::Parsers::Episode.new(source_uri)
          end

          # @return [EhbrsRubyUtils::Videos::Opensubtitles::Parsers::Title]
          def title_parser
            ::EhbrsRubyUtils::Videos::Opensubtitles::Parsers::Title.new(source_uri)
          end

          # @return [Aranha::DefaultProcessor]
          def sub_processor_uncached
            sub_processor_class.new(source_uri, extra_data)
          end
        end
      end
    end
  end
end
