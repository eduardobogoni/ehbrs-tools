# frozen_string_literal: true

RSpec.describe Ehbrs::Tools::Runner::Vg::Patch do
  include_context 'spec_paths', __FILE__

  describe '#run' do
    %w[ips vcdiff].each do |patch_extname|
      context "when the patches have extname \"#{patch_extname}\"" do
        let(:source_dir) { fixtures_directory.expand_path __dir__ }
        let(:source_file) { source_dir / 'source.rom' }
        let(:patches) { 2.times.map { |i| source_dir / "patch_#{i}.#{patch_extname}" } }
        let(:output_file) { EacRubyUtils::Fs::Temp.file }
        let(:expected_file) { source_dir / 'expected.rom' }
        let(:run_argv) do
          ['vg', 'patch', '--output-file', output_file.to_path, source_file.to_path] +
            patches.map(&:to_path)
        end

        before do
          Ehbrs::Tools::Runner.run(argv: run_argv)
        end

        after do
          output_file.unlink if output_file.exist?
        end

        it { expect(output_file).to exist }

        it do
          expect(FileUtils.compare_file(output_file.to_path, expected_file.to_path)).to be_truthy
        end
      end
    end
  end
end
