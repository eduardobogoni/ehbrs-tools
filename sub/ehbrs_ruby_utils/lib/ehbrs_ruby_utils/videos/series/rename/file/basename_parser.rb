# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos
    module Series
      module Rename
        class File < ::EhbrsRubyUtils::Videos::Series::Rename::LineResult
          module BasenameParser
            FORMATS = [{
              format: /(\d+)(\d{2})(\d{2})/i,
              build: ->(m) { { s: padding(m[1]), e: "#{padding(m[2])}-#{padding(m[3])}" } }
            }, {
              format: /s(\d+)e(\d+)-(\d+)/i,
              build: ->(m) { { s: padding(m[1]), e: "#{padding(m[2])}-#{padding(m[3])}" } }
            }, {
              format: /(\d{1,2})\s*[^\d]\s*(\d{2})/i,
              build: ->(m) { { s: padding(m[1]), e: padding(m[2]) } }
            }, {
              format: /(\d+)(\d{2})/i,
              build: ->(m) { { s: padding(m[1]), e: padding(m[2]) } }
            }, {
              format: /(\d{2})/i,
              build: ->(m) { { s: padding(1), e: padding(m[1]) } }
            }].freeze

            def self.padding(string)
              string.to_s.rjust(2, '0')
            end

            def parse_uncached
              FORMATS.each do |format|
                m = format.fetch(:format).match(current_name)
                return format.fetch(:build).call(m) if m
              end
              nil
            end
          end
        end
      end
    end
  end
end
