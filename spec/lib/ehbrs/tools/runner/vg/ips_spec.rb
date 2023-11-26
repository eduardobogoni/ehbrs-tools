# frozen_string_literal: true

require 'eac_ruby_utils/fs/temp'
require 'ehbrs/tools/runner'
require 'ehbrs/tools/runner/vg/ips'

RSpec.describe Ehbrs::Tools::Runner::Vg::Ips do
  let(:source_dir) { Pathname.new('ips_spec_files').expand_path __dir__ }
  let(:source_file) { source_dir / 'source.rom' }
  let(:patches) { 2.times.map { |i| source_dir / "patch_#{i}.ips" } }

  describe '#run' do
    let(:output_file) { EacRubyUtils::Fs::Temp.file }
    let(:expected_file) { source_dir / 'expected.rom' }
    let(:run_argv) do
      ['vg', 'ips', '--output-file', output_file.to_path, source_file.to_path] +
        patches.map(&:to_path)
    end

    before do
      Ehbrs::Tools::Runner.run(argv: run_argv)
    end

    after do
      output_file.unlink if output_file.exist?
    end

    it { expect(output_file).to exist }
    it { expect(FileUtils.compare_file(output_file.to_path, expected_file.to_path)).to be_truthy }
  end
end
