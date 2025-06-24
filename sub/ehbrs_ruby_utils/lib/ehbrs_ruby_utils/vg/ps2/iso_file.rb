# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Ps2
      class IsoFile < ::EhbrsRubyUtils::Fs::Iso9660File
        CODE_PATTERN = /[a-zA-Z]{4}_[0-9]{3}\.[0-9]{2}/.freeze
        CODE_PARSER = CODE_PATTERN.to_parser(&:to_s)

        # @return [String]
        def code
          list.lazy.map { |line| CODE_PARSER.parse(line) }.find(&:present?)
        end

        # @return [String]
        def basename_nocode_noext
          path.basename_noext.to_path.gsub(/\A#{::Regexp.quote(code)}/, '')
        end

        # @return [Path]
        def target_path
          path.basename_sub do |_b|
            "#{code}.#{path_basename}#{DEFAULT_EXTNAME}"
          end
        end

        # @return [Boolean]
        def valid?
          super && code.present?
        end

        private

        # @return [String]
        def path_basename
          path.basename_noext.to_path.gsub(/\A#{::Regexp.quote(code)}/, '')
            .gsub(/[^0-9a-zA-Z]+/, '_').gsub(/\A_+/, '').gsub(/_+\z/, '')
        end
      end
    end
  end
end
