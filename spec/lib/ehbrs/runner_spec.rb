# frozen_string_literal: true

require 'ehbrs/runner'
require 'ehbrs/tools/version'

RSpec.describe ::Ehbrs::Runner do
  let(:runner) { described_class.create(argv: argv) }

  describe '--version option' do
    let(:argv) { %w[--version] }

    it do
      expect { runner.run }.to(output("#{::Ehbrs::Tools::VERSION}\n").to_stdout_from_any_process)
    end
  end
end
