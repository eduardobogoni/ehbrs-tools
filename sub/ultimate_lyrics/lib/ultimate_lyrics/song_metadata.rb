# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module UltimateLyrics
  class SongMetadata
    require_sub __FILE__
    common_constructor :data do
      self.data = ::UltimateLyrics::SongMetadata::Field.lists.sources.hash_keys_validate!(data)
    end

    ::UltimateLyrics::SongMetadata::Field.lists.sources.each_value do |field|
      define_method field do
        data.fetch(field)
      end
    end

    # @param field [UltimateLyrics::Field]
    # @return [UltimateLyrics::SongMetadata::Field]
    def field(field)
      UltimateLyrics::SongMetadata::Field.new(self, field)
    end

    def to_s
      data.map { |k, v| "#{k}=#{v}" }.join(', ')
    end
  end
end
