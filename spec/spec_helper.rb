# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __dir__)
require 'tmpdir'

RSpec.configure do |config|
  config.example_status_persistence_file_path = ::File.join(::Dir.tmpdir, 'ehbrs-tools_rspec')
end

require 'eac_ruby_utils/core_ext'
::EacRubyUtils.require_sub __FILE__
