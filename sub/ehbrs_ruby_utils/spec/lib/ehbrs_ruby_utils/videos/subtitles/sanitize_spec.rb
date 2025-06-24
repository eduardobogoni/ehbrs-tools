# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::Videos::Subtitles::Sanitize do
  include_examples 'source_target_fixtures_raw', __FILE__

  def source_data(source_file)
    described_class.convert_to_string(source_file)
  end

  def target_file_extname
    '.srt'
  end
end
