# frozen_string_literal: true

require 'ehbrs/runner'

RSpec.describe ::Ehbrs::Runner::Videos::Probe do
  let(:source_dir) { ::Pathname.new(__dir__).expand_path / 'unsupported_spec_files' }
  let(:source_file) { source_dir / 'fixed.mp4' }
  let(:target_dir) { ::Pathname.new(__dir__).expand_path / 'probe_spec_files' }
  let(:target_file) { target_dir / 'fixed.target.yaml' }
  let(:target_content) { target_file.read }

  let(:argv) { %w[videos probe] + [source_file.to_path] }
  let(:runner) { ::Ehbrs::Runner.new(argv: argv) }

  describe '#run' do
    it do
      expect { runner.run }.to(output(target_content).to_stdout_from_any_process)
    end
  end
end
