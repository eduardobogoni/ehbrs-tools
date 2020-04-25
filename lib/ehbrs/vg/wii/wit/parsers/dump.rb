# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Vg
    module Wii
      module Wit
        module Parsers
          class Dump
            enable_simple_cache
            common_constructor :output

            FILE_DISC_TYPE_PATTERN = %r{\A(\S+)/(\S+)\s+&\s+(\S+)\z}.freeze

            private

            def properties_uncached
              r = {}
              output.each_line do |line|
                dump_output_line_to_hash(line).if_present { |v| r.merge!(v) }
              end
              r
            end

            def dump_output_line_to_hash(line)
              m = /\A\s*([^:]+):\s+(.+)\z/.match(line.strip)
              return nil unless m

              parse_attribute(m[1].strip, m[2].strip)
            end

            def line_method_parser(label)
              "parse_#{label}".parameterize.underscore
            end

            def parse_attribute(label, value)
              method = line_method_parser(label)
              return { label => value } unless respond_to?(method, true)

              send(method, value).map { |k, v| ["#{label}/#{k}", v] }.to_h
            end

            def parse_file_disc_type(value)
              FILE_DISC_TYPE_PATTERN
                .match(value)
                .if_present { |m| { type: m[1], platform_acronym: m[2], platform_name: m[3] } }
                .if_blank { raise "\"#{FILE_DISC_TYPE_PATTERN}\" does not match \"#{value}\"" }
            end

            def parse_disc_part_ids(value)
              value.split(',').map(&:strip).map do |v|
                r = v.split('=')
                [r[0].strip, r[1].strip]
              end.to_h
            end
          end
        end
      end
    end
  end
end
