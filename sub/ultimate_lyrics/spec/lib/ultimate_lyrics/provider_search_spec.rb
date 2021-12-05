# frozen_string_literal: true

require 'ultimate_lyrics/song_metadata'
require 'ultimate_lyrics/provider'
require 'ultimate_lyrics/provider_search'

::RSpec.describe ::UltimateLyrics::ProviderSearch do
  let(:song_metadata) do
    ::UltimateLyrics::SongMetadata.new(
      artist: 'Milton Nascimento',
      title: 'Rouxinol',
      album: 'Nascimento',
      track: '5',
      year: '1997'
    )
  end

  describe '#url' do
    {
      'azlyrics.com' => 'http://www.azlyrics.com/lyrics/milton nascimento/rouxinol.html',
      'bollywoodlyrics.com (Bollywood songs)' => 'http://www.bollywoodlyrics.com/lyric/Rouxinol',
      'darklyrics.com' => 'http://www.darklyrics.com/lyrics/miltonnascimento/nascimento.html',
      'directlyrics.com' => 'http://www.directlyrics.com/milton nascimento-rouxinol-lyrics.html',
      'elyrics.net' => 'http://www.elyrics.net/read/M/milton nascimento-lyrics/rouxinol-lyrics' \
        '.html',
      'Encyclopaedia Metallum' => 'http://www.metal-archives.com/search/ajax-advanced/searching' \
        '/songs/?songTitle=rouxinol&bandName=milton nascimento&ExactBandMatch=1',
      'genius.com' => 'https://www.genius.com/milton nascimento-rouxinol-lyrics',
      'hindilyrics.net (Bollywood songs)' => 'http://www.hindilyrics.net/lyrics/of-Rouxinol.html',
      'letras.mus.br' => 'https://www.letras.mus.br/winamp.php?musica=rouxinol' \
        '&artista=milton nascimento',
      'lololyrics.com' => 'http://api.lololyrics.com/0.5/getLyric?artist=milton nascimento' \
        '&track=rouxinol',
      'loudson.gs' => 'http://www.loudson.gs/M/milton nascimento/nascimento/rouxinol',
      'lyrics.com' => 'http://www.lyrics.com/lyrics/milton nascimento/rouxinol.html',
      'lyrics.wikia.com' => 'http://lyrics.wikia.com/Milton Nascimento:Rouxinol',
      'lyricsbay.com' => 'http://www.lyricsbay.com/rouxinol_lyrics-milton nascimento.html',
      'lyricsdownload.com' => 'http://www.lyricsdownload.com' \
        '/milton nascimento-rouxinol-lyrics.html',
      'lyricsmania.com' => 'http://www.lyricsmania.com/rouxinol_lyrics_milton nascimento.html',
      'lyricsmode.com' => 'http://www.lyricsmode.com/lyrics/M/milton nascimento/rouxinol.html',
      'lyricsplugin.com' => 'http://www.lyricsplugin.com/winamp03/plugin/?title=rouxinol' \
        '&artist=milton nascimento',
      'lyricsreg.com' => 'http://www.lyricsreg.com/lyrics/milton nascimento/rouxinol/',
      'lyricstime.com' => 'http://www.lyricstime.com/milton nascimento-rouxinol-lyrics.html',
      'lyriki.com' => 'http://www.lyriki.com/milton nascimento:rouxinol',
      'metrolyrics.com' => 'http://www.metrolyrics.com/rouxinol-lyrics-milton nascimento.html',
      'mp3lyrics.org' => 'http://www.mp3lyrics.org/M/milton nascimento/rouxinol/',
      'musixmatch.com' => 'https://www.musixmatch.com/lyrics/Milton Nascimento/Rouxinol',
      'seeklyrics.com' => 'http://www.seeklyrics.com/lyrics/Milton Nascimento/Rouxinol.html',
      'songlyrics.com' => 'http://www.songlyrics.com/milton nascimento/rouxinol-lyrics/',
      'tekstowo.pl (Original lyric language)' => 'http://www.tekstowo.pl/piosenka' \
        ',milton nascimento,rouxinol.html',
      'tekstowo.pl (Translated to Polish)' => 'http://www.tekstowo.pl/piosenka' \
        ',milton nascimento,rouxinol.html',
      'teksty.org' => 'http://teksty.org/milton nascimento,rouxinol,tekst-piosenki',
      'vagalume.com.br' => 'http://vagalume.com.br/milton nascimento/rouxinol.html',
      'vagalume.com.br (Portuguese translations)' => 'http://vagalume.com.br/milton nascimento' \
        '/rouxinol-traducao.html'

    }.each do |provider_name, expected_value|
      context "when provider is \"#{provider_name}\"" do
        let(:provider) { ::UltimateLyrics::Provider.by_name(provider_name) }
        let(:instance) { described_class.new(provider, song_metadata) }

        it do
          expect(instance.url).to eq(expected_value)
        end
      end
    end
  end
end
