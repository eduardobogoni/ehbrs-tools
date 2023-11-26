# frozen_string_literal: true

require 'ehbrs/tools/runner'
require 'ehbrs/tools/version'

RSpec.describe Ehbrs::Tools::Runner do
  let(:runner) { described_class.create(argv: argv) }

  describe '--version option' do
    let(:argv) { %w[--version] }

    it do
      expect { runner.run }.to(output("#{Ehbrs::Tools::VERSION}\n").to_stdout_from_any_process)
    end
  end
end
