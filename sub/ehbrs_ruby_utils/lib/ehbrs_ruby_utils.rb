# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  require 'aranha'
  require 'aranha/parsers'
  require 'aranha/selenium'
  require 'avm'
  require 'avm/eac_rails_base0'
  require 'eac_fs'
  require 'eac_rest'
  require 'eac_templates'
  require 'ultimate_lyrics'
end
