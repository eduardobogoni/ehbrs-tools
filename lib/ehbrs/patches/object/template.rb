# frozen_string_literal: true

require 'ehbrs/tools/application'
require 'eac_ruby_utils/patches/object/template'

::EacRubyUtils::Templates::Searcher.default.included_paths <<
  ::Ehbrs::Tools.application.gemspec_dir.join('template').to_path
