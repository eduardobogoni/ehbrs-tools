# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Languages
          class Track < ::Ehbrs::Tools::Runner::Videos::Languages::Labelized
            BLANK_LANGUAGE = 'BLANK'

            attr_reader :file

            def initialize(runner, object, file)
              super(runner, object)
              @file = file
            end

            def delete_ffmpeg_args
              return [] if included?

              ['-map', "-0:#{index}"]
            end

            def extract_ffmpeg_args
              return [] unless included?

              ['-map', "0:#{index}", extract_target]
            end

            def included?
              runner.keep_languages.include?(language)
            end

            def language
              language_with_title.presence || BLANK_LANGUAGE
            end

            def extract_target
              file.basename_sub('.*') { |b| "#{b}.#{language}_#{index}.srt" }
            end
          end
        end
      end
    end
  end
end
