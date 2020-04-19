# frozen_string_literal: true

require 'ehbrs/tools/runner'
require 'ehbrs/tools/runner/videos/unsupported'

RSpec.describe ::Ehbrs::Tools::Runner::Videos::Unsupported do
  let(:source_dir) { ::Pathname.new(__dir__).expand_path / 'unsupported_spec_files' }
  let(:source_file) { source_dir / 'fixed.mp4' }
  let(:temp_dir) { ::Pathname.new(::Dir.mktmpdir).expand_path }
  let(:to_fix_file) { temp_dir / 'to_fix_file.mp4' }

  before do
    ::Ehbrs::Executables.ffmpeg.command.append(
      ['-i', source_file.to_s, '-c:v', 'copy', '-c:a', 'dts', '-strict', '-2', to_fix_file.to_s]
    ).execute!
  end

  it { expect(to_fix_file.file?).to eq(true) }

  describe '#run' do
    let(:run_argv) { ['videos', 'unsupported', '-f', temp_dir.to_s] }
    let(:converted_file) { to_fix_file.basename_sub { |b| "#{b}.converted" } }
    let(:fixed_file) { to_fix_file.basename_sub { |b| "#{b.basename('.*')}.mkv" } }

    before do
      ::Ehbrs::Tools::Runner.run(argv: run_argv)
    end

    it { expect(converted_file).to be_a_file }
    it { expect(fixed_file).to be_a_file }
  end
end
