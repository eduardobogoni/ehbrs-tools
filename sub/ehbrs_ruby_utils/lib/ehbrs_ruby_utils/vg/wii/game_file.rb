# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/custom_format'
require 'ehbrs_ruby_utils/executables'
require 'ehbrs_ruby_utils/vg/wii/wit/parsers/dump'
require 'ehbrs_ruby_utils/vg/wii/wit/path'
require 'pathname'

module EhbrsRubyUtils
  module Vg
    module Wii
      class GameFile < ::Pathname
        enable_simple_cache

        DISC_NUMBER_PATTERN = /disc.?(\d)/i.freeze

        FORMAT = ::EacRubyUtils::CustomFormat.new(
          b: :basename,
          d: :dirname,
          D: :disc_number,
          e: :extname,
          i: :id6,
          m: :normalized_disc_name,
          n: :disc_name,
          N: :nintendont_basename,
          s: :sanitized_disc_name,
          t: :database_title,
          T: :disc_type
        )

        def database_title
          properties.fetch('DB title')
        end

        def disc_name
          properties.fetch('Disc name')
        end

        def disc_number
          DISC_NUMBER_PATTERN.if_match(basename.to_s, false) { |m| m[1].to_i }.if_present(1)
        end

        def disc_type
          properties.fetch('File & disc type/type')
        end

        def format(string)
          FORMAT.format(string).with(self)
        end

        def normalized_disc_name
          sanitized_disc_name.downcase
        end

        def nintendont_basename
          n = disc_number
          n == 1 ? 'game' : "disc#{n}"
        end

        def id6
          properties.fetch('Disc & part IDs/disc')
        end

        def sanitized_disc_name
          ::ActiveSupport::Inflector.transliterate(disc_name).gsub(/[^0-9a-z ]/i, '')
        end

        def valid?
          properties.present?
        end

        def wit_path
          ::EhbrsRubyUtils::Vg::Wii::Wit::Path.new(disc_type, self)
        end

        private

        def properties_uncached
          r = ::EhbrsRubyUtils::Executables.wit.command.append(['dump', to_s]).execute
          return nil unless r.fetch(:exit_code).zero?

          ::EhbrsRubyUtils::Vg::Wii::Wit::Parsers::Dump.new(r.fetch(:stdout)).properties
        end
      end
    end
  end
end
