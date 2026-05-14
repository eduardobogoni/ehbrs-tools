# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'ehbrs_ruby_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ehbrs_ruby_utils'
  s.version     = EhbrsRubyUtils::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'Utilities for EHB/RS\'s Ruby projects.'

  s.files = Dir['{lib,template}/**/*']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'aranha', '~> 0.20'
  s.add_dependency 'aranha-parsers', '~> 0.28'
  s.add_dependency 'aranha-selenium', '~> 0.14'
  s.add_dependency 'avm', '~> 0.100'
  s.add_dependency 'avm-eac_rails_base0', '~> 0.11', '>= 0.11.2'
  s.add_dependency 'dentaku', '~> 3.5', '>= 3.5.7'
  s.add_dependency 'eac_fs', '~> 0.20', '>= 0.20.2'
  s.add_dependency 'eac_rest', '~> 0.13'
  s.add_dependency 'eac_ruby_utils', '~> 0.131'
  s.add_dependency 'eac_templates', '~> 0.8', '>= 0.8.3'
  s.add_dependency 'inifile', '~> 3.0'
  s.add_dependency 'srt', '~> 0.1', '>= 0.1.5'
  s.add_dependency 'taglib-ruby', '~> 1.1', '>= 1.1.3'
  s.add_dependency 'ultimate_lyrics', '~> 0.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.13'
end
