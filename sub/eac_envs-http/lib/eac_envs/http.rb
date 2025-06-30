# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__

module EacEnvs
  module Http
  end
end

require 'eac_fs'
require 'faraday'
require 'faraday/follow_redirects'
require 'faraday/gzip'
require 'faraday/multipart'
require 'faraday/retry'
require 'json'
