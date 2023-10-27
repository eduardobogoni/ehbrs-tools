# frozen_string_literal: true

require 'ehbrs_ruby_utils/vg/wii/wit/parsers/dump'

RSpec.describe EhbrsRubyUtils::Vg::Wii::Wit::Parsers::Dump do
  include_examples 'source_target_fixtures', __FILE__

  def source_data(source_file)
    described_class.new(File.read(source_file)).properties
  end
end
