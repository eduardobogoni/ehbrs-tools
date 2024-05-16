# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Music
    module Sort
      module Files
        class Factory
          SECTION_CURRENT = 'A'
          SECTION_NEW = 'Z'
          SECTIONS = [SECTION_CURRENT, SECTION_NEW].freeze
          NO_ORDER = Float::INFINITY

          enable_simple_cache
          common_constructor :path, :config_data

          def basename
            by_pattern(3).if_present(path.basename.to_path)
          end

          def build
            ::EhbrsRubyUtils::Music::Sort::Files::Base.new(section, order, basename, path)
          end

          def order
            order_from_config_data || by_pattern(2).if_present(NO_ORDER, &:to_i)
          end

          def section
            r = section_from_config_data || by_pattern(1).if_present(SECTION_NEW)
            return SECTION_CURRENT if r.blank? || r.upcase == SECTION_CURRENT

            SECTION_NEW
          end

          private

          def by_pattern(index)
            match_builded_pattern.if_present { |v| v[index] }
          end

          def match_builded_pattern_uncached
            /\A([a-z])?([0-9]+)\s+(\S.*)\z/i.match(path.basename.to_path)
          end

          def order_from_config_data
            config_data.each_value do |files|
              files.index(basename).if_present { |v| return v + 1 }
            end
            nil
          end

          def section_from_config_data
            config_data.each do |section, files|
              return section if files.include?(basename)
            end
            nil
          end
        end
      end
    end
  end
end
