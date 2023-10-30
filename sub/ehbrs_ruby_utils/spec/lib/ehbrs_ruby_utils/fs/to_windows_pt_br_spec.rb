# frozen_string_literal: true

require 'ehbrs_ruby_utils/fs/to_windows_pt_br'

RSpec.describe EhbrsRubyUtils::Fs::ToWindowsPtBr do
  include_examples 'source_target_fixtures_raw', __FILE__

  def source_data(source_file)
    described_class.convert_to_string(source_file)
  end
end
