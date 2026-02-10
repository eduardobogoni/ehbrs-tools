# frozen_string_literal: true

module EhbrsRubyUtils
  module CookingBook
    class Recipe
      enable_simple_cache

      class << self
        def from_file(path)
          new(::EacRubyUtils::Yaml.load_file(path))
        end
      end

      common_constructor :source_data do
        self.source_data = source_data.deep_symbolize_keys
      end

      def title
        source_data.fetch(:title)
      end

      def notes
        source_data[:notes]
      end

      def parts
        @parts ||= source_data.fetch(:parts).map do |k, v|
          ::EhbrsRubyUtils::CookingBook::Recipe::Part.new(k, v)
        end
      end
    end
  end
end
