# frozen_string_literal: true

require 'ehbrs/vg/wii/wit/parsers/dump'

RSpec.describe ::Ehbrs::Vg::Wii::Wit::Parsers::Dump do
  include_examples 'source_target_fixtures', __FILE__

  def source_data(source_file)
    described_class.new(::File.read(source_file)).properties
  end
end
