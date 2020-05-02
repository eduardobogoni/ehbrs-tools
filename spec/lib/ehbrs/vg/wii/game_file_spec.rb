# frozen_string_literal: true

require 'ehbrs/vg/wii/game_file'

RSpec.describe ::Ehbrs::Vg::Wii::GameFile do
  [['game.iso', 1], ['disc1.iso', 1], ['disc2.iso', 2],
   ['Resident Evil - Code - Veronica X (USA) (Disc 1)', 1],
   ['Resident Evil - Code - Veronica X (USA) (Disc 2)', 2]].each do |s|
    context "when game file is #{s[0]}" do
      let(:game_file) { described_class.new(s[0]) }

      it "disc_number should be #{s[1]}" do
        expect(game_file.disc_number).to eq(s[1])
      end
    end
  end
end
