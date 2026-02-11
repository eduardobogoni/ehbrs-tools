# frozen_string_literal: true

RSpec.describe Ehbrs::Tools::Runner::Videos::Probe do
  let(:source_file) { stub_video_source_file }
  let(:target_dir) { Pathname.new(__dir__).expand_path / 'probe_spec_files' }
  let(:target_file) { target_dir / 'fixed.target.yaml' }
  let(:target_content) { target_file.read.gsub('%%PATH%%', source_file.to_path) }

  let(:argv) { %w[videos probe] + [source_file.to_path] }
  let(:runner) { Ehbrs::Tools::Runner.create(argv: argv) }

  describe '#run' do
    it do
      expect { runner.run }.to(output(target_content).to_stdout_from_any_process)
    end
  end
end
