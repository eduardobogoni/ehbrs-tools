# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos/opensubtitles/processors/subtitles_provider'

RSpec.describe EhbrsRubyUtils::Videos::Opensubtitles::Processors::SubtitlesProvider do
  describe '#episode?' do
    { false => 'title', true => 'episode' }.each do |expected, prefix|
      __dir__.to_pathname.parent.join("parsers/#{prefix}_spec_files").glob('*.html')
        .each do |source|
        context "when source is \"#{source}\"" do
          let(:instance) { described_class.new(source, {}) }

          it { expect(instance.episode?).to eq(expected) }
        end
      end
    end
  end
end
