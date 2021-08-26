# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'ehbrs/tools/version'

Gem::Specification.new do |s|
  s.name        = 'ehbrs-tools'
  s.version     = ::Ehbrs::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for EHB/RS.'

  s.files = Dir['{exe,lib,template,vendor}/**/*', 'Gemfile', 'Gemfile.lock', '.avm.yml']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.add_dependency 'avm-tools', '~> 0.82', '>= 0.82.1'
  s.add_dependency 'eac_cli', '~> 0.12', '>= 0.12.5'
  s.add_dependency 'eac_ruby_utils', '~> 0.71'
  s.add_dependency 'filesize'
  s.add_dependency 'inifile', '~> 3.0'
  s.add_dependency 'os'
  s.add_dependency 'telegram-bot-ruby'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.3'
end
