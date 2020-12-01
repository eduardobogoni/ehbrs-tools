# frozen_string_literal: true

require 'ehbrs/runner'
require 'eac_ruby_utils/fs/temp'
require 'ehbrs/runner/videos/unsupported'

RSpec.describe ::Ehbrs::Runner::Videos::Unsupported do
  let(:source_dir) { ::Pathname.new(__dir__).expand_path / 'unsupported_spec_files' }
  let(:temp_dir) { ::EacRubyUtils::Fs::Temp.directory }
  let(:dts_audio) do
    stub_video(['-c:v', 'copy', '-c:a', 'dts', '-strict', '-2'], temp_dir / 'to_fix_file.mp4')
  end

  ['dts_audio'].each do |video_var|
    context "when source file is #{video_var}" do
      let(:to_fix_file) { send(video_var) }

      before do
        to_fix_file
      end

      after do
        temp_dir.remove
      end

      it { expect(to_fix_file.file?).to eq(true) }
      it { expect(to_fix_file.dirname).to eq(temp_dir) }

      describe '#run' do
        let(:run_argv) { ['videos', 'unsupported', '-f', temp_dir.to_s] }
        let(:converted_file) { to_fix_file.basename_sub { |b| "#{b}.converted" } }
        let(:fixed_file) { to_fix_file.basename_sub { |b| "#{b.basename('.*')}.mkv" } }

        before do
          ::Ehbrs::Runner.run(argv: run_argv)
        end

        it { expect(converted_file).to be_a_file }
        it { expect(fixed_file).to be_a_file }
      end
    end
  end
end
