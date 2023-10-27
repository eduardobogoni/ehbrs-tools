# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/executables'
require 'ehbrs_ruby_utils/vg/wii/wit/parsers/info'

module EhbrsRubyUtils
  module Vg
    module Wii
      module Wit
        class ImageFormat
          class << self
            SECTION_NAME_PATTERN = /\A#{::Regexp.quote('IMAGE-FORMAT:')}(.+)\z/.freeze

            enable_simple_cache

            def by_name(name)
              all.find { |i| i.name.downcase == name.to_s.downcase } ||
                raise(::ArgumentError, "Image not found with name \"#{name.to_s.downcase}\" " \
                  "(Available: #{all.map(&:name).join(', ')})")
            end

            private

            def all_uncached
              ::EhbrsRubyUtils::Vg::Wii::Wit::Parsers::Info.new(info_output).images
                .map do |_label, data|
                new(
                  *%w[name info option].map { |k| data.fetch(k) },
                  *%w[extensions attributes].map { |k| data.fetch(k).to_s.split(/\s+/) }
                )
              end
            end

            def info_output
              ::Ehbrs::Executables.wit.command
                .append(%w[info image-format --sections])
                .execute!
            end
          end

          common_constructor :name, :description, :option, :extensions, :attributes
        end
      end
    end
  end
end
