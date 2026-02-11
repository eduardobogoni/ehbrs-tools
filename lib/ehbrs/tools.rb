# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__

module Ehbrs
  module Tools
    include ::Ehbrs::Tools::Application
  end
end

require 'avm/tools'
require 'eac_cli'
require 'eac_fs'
require 'eac_ruby_base0'
require 'ehbrs_ruby_utils'
