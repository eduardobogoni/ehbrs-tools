#!/usr/bin/env ruby
# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', __dir__)
require 'rubygems'
require 'bundler/setup'
$LOAD_PATH.unshift("#{__dir__}/../lib")

require 'ultimate_lyrics/song_metadata'
require 'ultimate_lyrics/provider'
require 'ultimate_lyrics/provider_search'
require 'aranha/parsers/source_address'
require 'aranha/parsers/source_address/fetch_content_error'
require 'eac_ruby_utils/core_ext'

class OriginalContentDownload
  enable_simple_cache
  common_constructor :song_metadata, :provider

  def run
    puts "Fetch content for #{provider_search}..."
    source_content.if_present do |v|
      source_file.write(v)
      url_file.write("#{provider_search.url.strip}\n")
    end
  end

  private

  def basename_file_uncached
    "#{provider.name.variableize}__#{"#{song_metadata.artist}_#{song_metadata.title}".variableize}"
  end

  def fixtures_dir_uncached
    __dir__.to_pathname.parent.join('spec', 'lib', 'ultimate_lyrics', 'parser_spec_files')
  end

  def provider_search_uncached
    ::UltimateLyrics::ProviderSearch.new(provider, song_metadata)
  end

  def source_content
    r = ::Aranha::Parsers::SourceAddress.detect_sub(provider_search.url).content
    puts 'SUCCESS: content fetched'
    r
  rescue ::Aranha::Parsers::SourceAddress::FetchContentError => e
    puts "ERROR: #{e.message}"
    nil
  end

  def source_file
    fixtures_dir.join("#{basename_file}.source.html")
  end

  def url_file
    fixtures_dir.join("#{basename_file}.url")
  end
end

class OriginalContentDownloads
  SONG_METADATAS = [{
    artist: 'Michael Jackson',
    title: 'Thriller',
    album: 'Thriller',
    track: '4',
    year: '1982'
  }, {
    artist: 'Milton Nascimento',
    title: 'Rouxinol',
    album: 'Nascimento',
    track: '5',
    year: '1997'
  }].freeze

  def run
    downloads.each(&:run)
  end

  def downloads
    song_metadatas.lazy.flat_map do |song_metadata|
      providers.map { |provider| ::OriginalContentDownload.new(song_metadata, provider) }
    end
  end

  def song_metadatas
    SONG_METADATAS.map { |data| ::UltimateLyrics::SongMetadata.new(data) }
  end

  def providers
    ::UltimateLyrics::Provider.all
  end
end

OriginalContentDownloads.new.run
