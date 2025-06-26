# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__ do
  ignore 'core_ext'
  ignore 'patches'
end

module EacRubyBase0
end

require 'eac_ruby_base0/core_ext'
