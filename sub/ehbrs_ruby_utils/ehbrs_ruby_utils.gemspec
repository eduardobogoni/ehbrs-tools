# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'ehbrs_ruby_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ehbrs_ruby_utils'
  s.version     = ::EhbrsRubyUtils::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'Utilities for EHB/RS\'s Ruby projects.'

  s.files = Dir['{lib,template}/**/*']
  s.test_files = Dir['{spec}/**/*', '.rubocop.yml', '.rspec']

  s.add_dependency 'aranha', '~> 0.19', '>= 0.19.2'
  s.add_dependency 'aranha-parsers', '~> 0.21'
  s.add_dependency 'aranha-selenium', '~> 0.7'
  s.add_dependency 'avm', '~> 0.79'
  s.add_dependency 'dentaku', '~> 3.5', '>= 3.5.1'
  s.add_dependency 'eac_fs', '~> 0.16'
  s.add_dependency 'eac_rest', '~> 0.9', '>= 0.9.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.118'
  s.add_dependency 'eac_templates', '~> 0.5'
  s.add_dependency 'taglib-ruby', '~> 1.1', '>= 1.1.3'
  s.add_dependency 'ultimate_lyrics', '~> 0.1', '>= 0.1.3'

  s.add_development_dependency 'aranha-parsers', '~> 0.8'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
