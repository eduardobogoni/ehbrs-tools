# frozen_string_literal: true

require 'eac_cli/runner'
require 'eac_ruby_utils/core_ext'

module EacCli
  module RunnerWith
    module Subcommands
      require_sub __FILE__

      class << self
        def runner?(object)
          ::EacCli::Runner.runner?(object) || (
            object.is_a?(::Class) && object < ::EacCli::DocoptRunner
          )
        end
      end

      common_concern do
        include ::EacCli::Runner
        runner_definition.singleton_class
                         .include(::EacCli::RunnerWith::Subcommands::DefinitionConcern)
      end

      EXTRA_AVAILABLE_SUBCOMMANDS_METHOD_NAME = :extra_available_subcommands

      def available_subcommands
        @available_subcommands ||= available_subcommands_auto.merge(available_subcommands_extra)
      end

      def available_subcommands_auto
        self.class.constants
            .map { |name| [name.to_s.underscore.gsub('_', '-'), self.class.const_get(name)] }
            .select { |c| ::EacCli::RunnerWith::Subcommands.runner?(c[1]) }
            .to_h.with_indifferent_access
      end

      def available_subcommands_extra
        if respond_to?(EXTRA_AVAILABLE_SUBCOMMANDS_METHOD_NAME, true)
          send(EXTRA_AVAILABLE_SUBCOMMANDS_METHOD_NAME)
        else
          {}
        end
      end

      def help_extra_text
        (['Subcommands:'] + available_subcommands.keys.sort.map { |s| "  #{s}" })
          .map { |v| "#{v}\n" }.join
      end

      def method_missing(method_name, *arguments, &block)
        return run_with_subcommand(*arguments, &block) if
        run_with_subcommand_alias_run?(method_name)

        super
      end

      def respond_to_missing?(method_name, include_private = false)
        run_with_subcommand_alias_run?(method_name) || super
      end

      def run_with_subcommand
        if subcommand_name
          if subcommand_runner.respond_to?(:run_run)
            subcommand_runner.run_run
          else
            subcommand_runner.run
          end
        else
          run_without_subcommand
        end
      end

      def run_with_subcommand_alias_run?(method_name)
        subcommands? && method_name.to_sym == :run
      end

      def run_without_subcommand
        "Method #{__method__} should be overrided in #{self.class.name}"
      end

      def subcommands?
        self.class.runner_definition.subcommands?
      end

      def subcommand_args
        parsed.fetch(::EacCli::Definition::SUBCOMMAND_ARGS_ARG)
      end

      def subcommand_class
        available_subcommands[subcommand_name].if_present { |v| return v }

        raise(::EacCli::Parser::Error.new(
                self.class.runner_definition, runner_context.argv,
                "Subcommand \"#{subcommand_name}\" not found " \
                  "(Available: #{available_subcommands.keys}"
              ))
      end

      def subcommand_name
        parsed.fetch(::EacCli::Definition::SUBCOMMAND_NAME_ARG)
      end

      def subcommand_program
        subcommand_name
      end

      def subcommand_runner
        @subcommand_runner ||= subcommand_class.create(
          argv: subcommand_args,
          program_name: subcommand_program,
          parent: self
        )
      end
    end
  end
end
