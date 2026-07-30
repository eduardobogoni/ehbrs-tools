# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  require 'avm/tools'
  require 'eac_cli'
  require 'eac_fs'
  require 'eac_ruby_base0'
  require 'ehbrs_ruby_utils'
end

module Ehbrs
  module Tools
    include ::Ehbrs::Tools::Application
  end
end
