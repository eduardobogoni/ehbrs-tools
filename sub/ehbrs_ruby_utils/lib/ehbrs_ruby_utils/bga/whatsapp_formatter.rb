# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module WhatsappFormatter
      common_concern do
        acts_as_abstract
      end

      LINE_SEPARATOR = "\n"
      OPTION_SEPARATOR = LINE_SEPARATOR
      SECTION_SEPARATOR = "#{LINE_SEPARATOR}#{LINE_SEPARATOR}"

      # @param content [String, Enumerable]
      # @return [String]
      def content_to_s(content)
        if content.is_a?(::Hash)
          content_to_s(
            content.map { |k, v| ::EhbrsRubyUtils::Bga::WhatsappFormatter::Option.new(k, v) }
          )
        elsif content.is_a?(::Enumerable)
          content.to_a.join(OPTION_SEPARATOR)
        else
          content.to_s
        end
      end

      # @return [EhbrsRubyUtils::Bga::Game]
      def game
        raise_abstract_method __method__
      end

      # @return [Pathname]
      def image_local_path
        game.box_large_image.local_path
      end

      # @param options [Enumerable<EhbrsRubyUtils::Bga::WhatsappFormatters::Option>]
      # @return [String]
      def options_to_s(options)
        options.map { |o| "#{o}#{OPTION_SEPARATOR}" }
      end

      # @param title {String]
      # @param content {String]
      # @return [String]
      def section_to_s(title, content)
        [title_to_s(title), content_to_s(content)].map(&:strip).join(SECTION_SEPARATOR)
      end

      # @return [Hash<String, String>] "title" => "content"
      def sections
        raise_abstract_method __method__
      end

      # @return [String]
      def title_icon
        raise_abstract_method __method__
      end

      def to_s
        sections.map { |title, content| section_to_s(title, content) }.join(SECTION_SEPARATOR)
      end

      def title_to_s(title)
        "*#{[title_icon, title, title_icon].join(' ')}*"
      end
    end
  end
end
