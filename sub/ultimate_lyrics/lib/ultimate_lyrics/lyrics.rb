# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module UltimateLyrics
  class Lyrics
    common_constructor :song_metadata, :provider_name, :text

    def found?
      text.present?
    end
  end
end
