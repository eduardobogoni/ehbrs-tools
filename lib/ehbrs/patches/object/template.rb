# frozen_string_literal: true

require 'ehbrs/tools/application'
require 'eac_templates/patches/object/template'

::EacTemplates::Searcher.default.included_paths <<
  ::Ehbrs::Tools.application.gemspec_dir.join('template').to_path
