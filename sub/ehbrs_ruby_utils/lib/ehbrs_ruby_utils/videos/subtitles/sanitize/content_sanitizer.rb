# frozen_string_literal: true

require 'srt'

module EhbrsRubyUtils
  module Videos
    module Subtitles
      class Sanitize < ::EhbrsRubyUtils::Fs::ToFileFormat
        class ContentSanitizer
          class << self
            def build_pattern(slim, elim)
              /#{::Regexp.quote(slim)}[^#{::Regexp.quote(elim)}]*#{::Regexp.quote(elim)}/
            end
          end

          REMOVE_PATTERNS = [%w[< >], %w[( )], ['[', ']']].map do |args|
            build_pattern(*args)
          end.freeze
          REMOVE_TERMS = %w[subtitle osdb legenda @ united4ever unitedteam pt-subs capejuna maniacs
                            |]
                           .map(&:downcase)

          common_constructor :input

          def line_processors
            REMOVE_PATTERNS.map do |pattern|
              ::EhbrsRubyUtils::Videos::Subtitles::Sanitize::WithPatternMatcher.new(pattern)
            end
          end

          def output
            output_lines.join("\n")
          end

          def output_lines
            r = []
            last_output_line = nil
            ::SRT::File.parse_string(input).lines.each do |input_line|
              output_line(input_line, last_output_line).if_present do |v|
                r << v
                last_output_line = v
              end
            end
            r
          end

          def output_line(input_line, last_output_line)
            text = output_line_text(input_line.text)
            return nil if text.blank?

            r = input_line.dup
            r.sequence = last_output_line.if_present(1) { |v| v.sequence + 1 }
            r.text = text
            r
          end

          def output_line_text(text)
            text_processors.each do |term|
              text = term.process(text)
              return nil if text.blank?
            end

            text.map { |line| process_line(line) }.compact_blank
          end

          def process_line(line)
            remove_tags(line)
          end

          def remove_tags(line)
            line_processors.inject(line) { |a, e| e.process(a) }.strip
          end

          def text_processors
            REMOVE_TERMS.map do |term|
              ::EhbrsRubyUtils::Videos::Subtitles::Sanitize::WithTermMatcher.new(term)
            end
          end
        end
      end
    end
  end
end
