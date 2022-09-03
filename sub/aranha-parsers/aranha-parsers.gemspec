# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'aranha/parsers/version'

Gem::Specification.new do |s|
  s.name        = 'aranha-parsers'
  s.version     = ::Aranha::Parsers::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Parsers\' utilities for Ruby.'

  s.files = Dir['{lib}/**/*', 'Gemfile']

  s.add_dependency 'activesupport', '>= 4.0.0'
  s.add_dependency 'addressable', '~> 2.7'
  s.add_dependency 'curb', '~> 0.9.10'
  s.add_dependency 'eac_ruby_utils', '~> 0.92', '>= 0.92.1'
  s.add_dependency 'faraday-gzip', '~> 0.1'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'nokogiri', '~> 1.12', '>= 1.12.4'
  s.add_dependency 'ofx-parser', '~> 1.1.0'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
