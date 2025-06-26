# frozen_string_literal: true

require 'eac_config/node'
require 'eac_fs/contexts'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/speaker'

module EacRubyBase0
  module Runner
    module Contexts
      def on_context(&block)
        top_block = block
        available_contexts.each do |context|
          next if context.object.any?

          last_block = top_block
          top_block = proc { context.object.on(context.builder.call, &last_block) }
        end
        top_block.call
      end

      private

      # @return [Array<EacRubyUtils::Struct>]
      def available_contexts
        (filesystem_available_contexts + [
          [:config, ::EacConfig::Node.context,
           -> { runner_context.call(:application).build_config }],
          [:speaker, ::EacRubyUtils::Speaker.context, -> { build_speaker }]
        ]).map { |row| available_context_row_to_struct(row) }
      end

      def available_context_row_to_struct(row)
        %i[type object builder].zip(row).to_h.to_struct
      end

      def build_speaker
        options = {}
        options[:err_out] = ::StringIO.new if parsed.quiet?
        options[:in_in] = ::EacCli::Speaker::InputBlocked.new if parsed.no_input?
        ::EacCli::Speaker.new(options)
      end

      def filesystem_available_contexts
        ::EacFs::Contexts::TYPES.map do |type|
          key = :"fs_#{type}"
          [key, ::EacFs::Contexts.send(type), -> { application.send("self_#{key}") }]
        end
      end
    end
  end
end
