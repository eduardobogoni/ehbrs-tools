# frozen_string_literal: true

RSpec.describe EhbrsRubyUtils::Videos::Resolution do
  describe '#quality' do
    { [500, 720] => 480, [1080, 720] => 720, [1, 1] => 240, [9999, 9999] => 2160,
      [480, 420] => 240, [480, 421] => 480 }.each do |resolution_parts, quality_height|
      context "when resolution is #{described_class.new(*resolution_parts).to_xs}" do
        let(:instance) { described_class.new(*resolution_parts) }

        it "quality is #{EhbrsRubyUtils::Videos::Quality.by_height(quality_height).to_xs}" do
          expect(instance.quality.height).to eq(quality_height)
        end
      end
    end
  end
end
