# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__ do
  ignore 'core_ext'
  ignore 'patches'
end

module EacRubyBase0
end

require 'avm/eac_ruby_base1'
require 'eac_cli'
require 'eac_config'
require 'eac_fs'
require 'eac_ruby_base0/core_ext'
