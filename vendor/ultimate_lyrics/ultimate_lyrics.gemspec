# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'ultimate_lyrics/version'

Gem::Specification.new do |s|
  s.name        = 'ultimate_lyrics'
  s.version     = UltimateLyrics::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.75'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.4'
end
