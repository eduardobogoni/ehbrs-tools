# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_ruby_base0/version'

Gem::Specification.new do |s|
  s.name        = 'eac_ruby_base0'
  s.version     = EacRubyBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'avm-eac_ruby_base1', '~> 0.33', '>= 0.33.1'
  s.add_dependency 'eac_cli', '~> 0.38', '>= 0.38.1'
  s.add_dependency 'eac_fs', '~> 0.18', '>= 0.18.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.126'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.11', '>= 0.11.1'
end
