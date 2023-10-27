# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'ehbrs/tools/version'

Gem::Specification.new do |s|
  s.name        = 'ehbrs-tools'
  s.version     = ::Ehbrs::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for EHB/RS.'

  s.files = Dir['{exe,lib,template,vendor}/**/*', 'Gemfile', 'Gemfile.lock', '.avm.yml']
  s.test_files = Dir['{spec}/**/*', '.rubocop.yml', '.rspec']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.add_dependency 'avm-tools', '~> 0.156'
  s.add_dependency 'eac_cli', '~> 0.38'
  s.add_dependency 'eac_ruby_utils', '~> 0.112'
  s.add_dependency 'ehbrs_ruby_utils', '~> 0.22'
  s.add_dependency 'filesize', '~> 0.2'
  s.add_dependency 'inifile', '~> 3.0'
  s.add_dependency 'os', '~> 1.1', '>= 1.1.4'
  s.add_dependency 'telegram-bot-ruby', '~> 0.23'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
