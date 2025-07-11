# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'ehbrs/tools/version'

Gem::Specification.new do |s|
  s.name        = 'ehbrs-tools'
  s.version     = Ehbrs::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for EHB/RS.'

  s.files = Dir['{exe,lib,template,vendor}/**/*', 'Gemfile', 'Gemfile.lock', '.avm.yml']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency 'avm-files', '~> 0.9'
  s.add_dependency 'avm-tools', '~> 0.163', '>= 0.163.3'
  s.add_dependency 'eac_cli', '~> 0.43', '>= 0.43.1'
  s.add_dependency 'eac_fs', '~> 0.19'
  s.add_dependency 'eac_ruby_base0', '~> 0.19', '>= 0.19.2'
  s.add_dependency 'eac_ruby_utils', '~> 0.128', '>= 0.128.3'
  s.add_dependency 'ehbrs_ruby_utils', '~> 0.45'
  s.add_dependency 'filesize', '~> 0.2'
  s.add_dependency 'os', '~> 1.1', '>= 1.1.4'
  s.add_dependency 'telegram-bot-ruby', '~> 0.23'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.12'
end
