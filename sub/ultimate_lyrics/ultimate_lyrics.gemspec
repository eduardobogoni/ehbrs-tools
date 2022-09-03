# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'ultimate_lyrics/version'

Gem::Specification.new do |s|
  s.name        = 'ultimate_lyrics'
  s.version     = UltimateLyrics::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'Fetch song lyrics from popular websites.'
  s.homepage    = 'https://rubygems.org/gems/ultimate_lyrics'
  s.metadata    = { 'source_code_uri' => 'https://github.com/esquilo-azul/ultimate_lyrics' }

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'aranha-parsers', '~> 0.10'
  s.add_dependency 'eac_ruby_utils', '~> 0.74'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.4'
end
