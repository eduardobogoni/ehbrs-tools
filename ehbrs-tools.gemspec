# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'ehbrs/tools/version'

Gem::Specification.new do |s|
  s.name        = 'ehbrs-tools'
  s.version     = ::Ehbrs::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for EHB/RS.'

  s.files = Dir['{exe,lib,vendor}/**/*', 'Gemfile']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.add_dependency 'avm-tools', '~> 0.44', '>= 0.44.2'
  s.add_dependency 'eac_ruby_utils', '~> 0.19'
  s.add_dependency 'filesize'
  s.add_dependency 'inifile', '~> 3.0'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1'
end
