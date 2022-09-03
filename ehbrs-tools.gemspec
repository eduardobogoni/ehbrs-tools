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

  s.add_dependency 'avm-tools', '~> 0.135'
  s.add_dependency 'eac_cli', '~> 0.27', '>= 0.27.8'
  s.add_dependency 'eac_ruby_utils', '~> 0.102', '>= 0.102.1'
  s.add_dependency 'ehbrs_ruby_utils', '~> 0.17', '>= 0.17.3'
  s.add_dependency 'filesize'
  s.add_dependency 'inifile', '~> 3.0'
  s.add_dependency 'os'
  s.add_dependency 'telegram-bot-ruby'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.3'
end
