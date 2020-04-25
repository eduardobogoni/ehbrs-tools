# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Vg
    module Wii
      module Wit
        class Path
          WIT_PATH_PATTERN = /\A(?:([a-z0-9]+):)?(.+)\z/i.freeze

          class << self
            def assert(source)
              source = parse(source) unless source.is_a?(self)
              source
            end

            def parse(path)
              WIT_PATH_PATTERN
                .match(path)
                .if_present { |m| new(m[1], m[2]) }
                .if_blank { raise "\"#{WIT_PATH_PATTERN}\" does not match \"#{path}\"" }
            end
          end

          common_constructor :type, :path do
            self.type = type.to_s.upcase
            self.path = ::Pathname.new(path.to_s)
          end

          def change?(other)
            type_change?(other) || path_change?(other)
          end

          def path_change?(other)
            path.expand_path.to_s != other.path.expand_path.to_s
          end

          def to_s
            r = path.to_s
            r = "#{type.to_s.upcase}:#{r}" if type.present?
            r
          end

          def type_change?(other)
            return false if other.type.blank?
            return true if type.blank?

            type != other.type
          end
        end
      end
    end
  end
end
