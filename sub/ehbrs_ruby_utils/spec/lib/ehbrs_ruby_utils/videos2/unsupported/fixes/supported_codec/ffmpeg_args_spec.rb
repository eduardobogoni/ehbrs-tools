# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::Videos2::Unsupported::Fixes::SupportedCodec, '#ffmpeg_args' do
  include_examples 'source_target_fixtures', __FILE__

  def source_data(source_file)
    stream = EhbrsRubyUtils::Videos::Stream.new(YAML.load_file(source_file))
    described_class.new.ffmpeg_args(stream)
  end
end
