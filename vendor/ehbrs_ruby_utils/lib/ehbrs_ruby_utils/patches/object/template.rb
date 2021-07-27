# frozen_string_literal: true

require 'eac_templates/patches/object/template'

::EacTemplates::Searcher.default.included_paths <<
  ::File.expand_path('../../../../template', __dir__)
