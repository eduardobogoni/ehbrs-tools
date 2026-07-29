# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  require 'eac_fs'
  require 'faraday'
  require 'faraday/follow_redirects'
  require 'faraday/gzip'
  require 'faraday/multipart'
  require 'faraday/retry'
  require 'json'
end
