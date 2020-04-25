# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/custom_format'
require 'ehbrs/vg/wii/wit/parsers/dump'
require 'ehbrs/vg/wii/wit/path'
require 'pathname'

module Ehbrs
  module Vg
    module Wii
      class GameFile < ::Pathname
        enable_simple_cache

        FORMAT = ::EacRubyUtils::CustomFormat.new(
          b: :basename,
          d: :dirname,
          e: :extname,
          i: :id6,
          n: :disc_name,
          t: :database_title,
          T: :disc_type
        )

        def database_title
          properties.fetch('DB title')
        end

        def disc_name
          properties.fetch('Disc name')
        end

        def disc_type
          properties.fetch('File & disc type/type')
        end

        def format(string)
          FORMAT.format(string).with(self)
        end

        def id6
          properties.fetch('Disc & part IDs/disc')
        end

        def valid?
          properties.present?
        end

        def wit_path
          ::Ehbrs::Vg::Wii::Wit::Path.new(disc_type, self)
        end

        private

        def properties_uncached
          r = ::Ehbrs::Executables.wit.command.append(['dump', to_s]).execute
          return nil unless r.fetch(:exit_code).zero?

          ::Ehbrs::Vg::Wii::Wit::Parsers::Dump.new(r.fetch(:stdout)).properties
        end
      end
    end
  end
end
