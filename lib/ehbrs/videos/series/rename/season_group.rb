# frozen_string_literal: true

require_relative 'line_result'

module Ehbrs
  module Videos
    module Series
      module Rename
        class SeasonGroup < ::Ehbrs::Videos::Series::Rename::LineResult
          attr_reader :season, :files

          def initialize(season, files)
            @season = season
            @files = files.sort_by { |f| [f.episode] }
          end

          def line_out
            'Season: '.cyan + "#{season} (#{first_episode} - #{last_episode})"
          end

          def show(level)
            super
            files.each { |file| file.show(level + 1) }
          end

          private

          def first_episode
            files.first.episode
          end

          def last_episode
            files.last.episode
          end
        end
      end
    end
  end
end
