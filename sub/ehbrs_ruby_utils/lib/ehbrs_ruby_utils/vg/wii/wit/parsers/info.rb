# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/executables'
require 'fileutils'
require 'inifile'

module EhbrsRubyUtils
  module Vg
    module Wii
      module Wit
        module Parsers
          class Info
            SECTION_NAME_PATTERN = /\A#{::Regexp.quote('IMAGE-FORMAT:')}(.+)\z/.freeze

            enable_simple_cache
            common_constructor :output

            private

            def images_uncached
              ini = ::IniFile.new(content: output)
              r = {}
              ini.sections.each do |section_name|
                image_section_name = parse_image_section_name(section_name)
                r[image_section_name] = ini[section_name] if image_section_name.present?
              end
              r
            end

            def parse_image_section_name(section_name)
              SECTION_NAME_PATTERN.match(section_name).if_present { |m| m[1] }
            end
          end
        end
      end
    end
  end
end
