# frozen_string_literal: true

module EacRubyBase0
  module Runner
    require_sub __FILE__
    enable_speaker
    common_concern do
      include ::EacCli::RunnerWith::Help
      include ::EacCli::RunnerWith::Subcommands
      include ::EacRubyBase0::Runner::Contexts
      prepend ::EacRubyBase0::Runner::Prepend
      runner_definition do
        bool_opt '-q', '--quiet', 'Quiet mode.'
        bool_opt '-I', '--no-input', 'Fail if a input is requested.'
        subcommands
        alt do
          bool_opt '-V', '--version', 'Show version.', usage: true, required: true
        end
      end
    end

    def application_version
      runner_context.call(:application).version.to_s
    end

    def show_version
      out("#{application_version}\n")
    end
  end
end
