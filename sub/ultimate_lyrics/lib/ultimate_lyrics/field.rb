# frozen_string_literal: true

module UltimateLyrics
  class Field
    DATA = {
      'artist' => %w[artist lower],
      'artist2' => %w[artist lower nospace],
      'album' => %w[album lower],
      'album2' => %w[album lower nospace],
      'title' => %w[title lower],
      'Artist' => %w[artist],
      'Album' => %w[album],
      'ARTIST' => %w[artist upper],
      'year' => %w[year pretty],
      'Title' => %w[title],
      'Title2' => %w[title titlecase],
      'a' => %w[artist firstchar],
      'track' => %w[track number]
    }.freeze

    BEGIN_DELIMITER = '{'
    END_DELIMITER = '}'

    class << self
      # @return [Array<UltimateLyrics::Field>]
      def all
        @all ||= DATA.map do |name, modifiers|
          source_attr = modifiers.shift
          new(name, source_attr, modifiers)
        end
      end

      # @return [UltimateLyrics::Field]
      def by_name(name)
        all.find { |field| field.name == name } ||
          raise("No field with name \"#{name}\" (Available: #{all.values})")
      end

      # @return [Array<UltimateLyrics::Field>]
      def from_string(string)
        names_from_string(string).map { |name| by_name(name) }
      end

      # @return [Array<String>]
      def names_from_string(string)
        string.scan(/#{::Regexp.quote(BEGIN_DELIMITER)}[^}]+#{::Regexp.quote(END_DELIMITER)}/)
              .map { |s| s.delimited_inner(BEGIN_DELIMITER, END_DELIMITER) }
      end
    end

    common_constructor :name, :source_attribute, :modifiers

    def apply(string, value)
      string.gsub(apply_pattern, value)
    end

    def apply_pattern
      /#{::Regexp.quote(BEGIN_DELIMITER)}#{::Regexp.quote(name)}#{::Regexp.quote(END_DELIMITER)}/
    end

    def value(value)
      modifiers.inject(value.to_s) { |a, e| send(e, a) }
    end

    def to_s
      name
    end

    private

    def firstchar(string)
      string[0]
    end

    def lower(string)
      string.downcase
    end

    def nospace(string)
      string.gsub(/\s/, '')
    end
  end
end
