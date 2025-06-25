# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/executables'

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Languages
          class FileRunner
            enable_simple_cache
            enable_speaker
            common_constructor :runner, :file do
              run
            end

            private

            def run
              start_banner
              extract_check || delete_check
            end

            def start_banner
              infov 'File', file
              infov "  * Tracks (#{tracks.count})", tracks.map(&:to_label).join(', ')
              infov "  * Languages (#{languages.count})", languages.map(&:to_label).join(', ')
            end

            def tracks_uncached
              audios_if_selected + subtitles_if_selected
            end

            def audios_if_selected
              return [] unless runner.include_audios?

              container.audios.map do |s|
                ::Ehbrs::Tools::Runner::Videos::Languages::Track.new(runner, s, file)
              end
            end

            def subtitles_if_selected
              return [] unless runner.include_subtitles?

              container.subtitles.map do |s|
                ::Ehbrs::Tools::Runner::Videos::Languages::Track.new(runner, s, file)
              end
            end

            def included_tracks_uncached
              tracks.select(&:included?)
            end

            def container_uncached
              ::EhbrsRubyUtils::Videos::File.new(file)
            end

            def track_label(track)
              track.to_s.green
            end

            def languages_uncached
              ::Set.new(
                tracks.map do |s|
                  ::Ehbrs::Tools::Runner::Videos::Languages::Language.new(runner, s.language)
                end
              ).to_a.sort
            end

            def delete_check
              return unless runner.delete?

              infov 'Delete args', ::Shellwords.join(delete_tracks_job_args)
              delete_tracks_job.run
            end

            def delete_tracks_job_uncached
              ::EhbrsRubyUtils::Videos::ConvertJob.new(file, delete_tracks_job_args)
            end

            def delete_tracks_job_args
              %w[-map 0] + tracks.flat_map(&:delete_ffmpeg_args) + %w[-c copy]
            end

            def extract_check # rubocop:disable Naming/PredicateMethod
              return false unless runner.extract?

              unless included_tracks.any?
                infom 'No selected tracks'
                return true
              end

              infov 'Extract args', ::Shellwords.join(extract_tracks_job_args)
              extract_tracks_command.system!
              true
            end

            def extract_tracks_job_args
              ['-txt_format', 'text', '-i', file] + tracks.flat_map(&:extract_ffmpeg_args)
            end

            def extract_tracks_command_uncached
              ::EhbrsRubyUtils::Executables.ffmpeg.command(*extract_tracks_job_args)
            end
          end
        end
      end
    end
  end
end
