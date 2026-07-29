# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_envs/http/version'

Gem::Specification.new do |s|
  s.name        = 'eac_envs-http'
  s.version     = EacEnvs::Http::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'eac_fs', '~> 0.20'
  s.add_dependency 'eac_ruby_utils', '~> 0.129'
  s.add_dependency 'faraday', '~> 2.14', '>= 2.14.1'
  s.add_dependency 'faraday-follow_redirects', '~> 0.5'
  s.add_dependency 'faraday-gzip', '~> 0.1'
  s.add_dependency 'faraday-multipart', '~> 1.2'
  s.add_dependency 'faraday-retry', '~> 2.4'
  s.add_dependency 'random-port', '~> 0.7', '>= 0.7.6'
  s.add_dependency 'webrick'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.12', '>= 0.12.1'
end
