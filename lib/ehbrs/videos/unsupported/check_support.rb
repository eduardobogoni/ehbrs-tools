# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/videos/unsupported/check_result'

module Ehbrs
  module Videos
    module Unsupported
      module CheckSupport
        common_concern do
          enable_simple_cache
          enable_speaker
        end

        def aggressions_banner(title)
          return if passed?

          info title
          pad_speaker do
            unpassed_checks.each do |u|
              info "* #{u.message}"
            end
          end
        end

        def ffmpeg_fix_args
          unpassed_checks.flat_map do |check|
            check.check.fix.if_present([]) { |v| v.ffmpeg_args(self) }
          end
        end

        def passed?
          unpassed_checks.none?
        end

        private

        def unpassed_checks_uncached
          checks.reject(&:passed?)
        end

        def checks_uncached
          options.fetch(check_set_key).checks.map do |check|
            ::Ehbrs::Videos::Unsupported::CheckResult.new(self, check)
          end
        rescue StandardError => e
          raise "#{e.message} (Source: #{self})"
        end

        def fix_blocks_uncached
          checks.reject(&:passed?).select { |c| c.check.fix.blank? }
        end

        def fixes_uncached
          checks.reject(&:passed?).map { |c| c.check.fix }.compact_blank
        end

        def pad_speaker(&block)
          ::EacRubyUtils::Speaker.context.on(::EacCli::Speaker.new(err_line_prefix: '  '), &block)
        end

        def new_padded_cli_speaker
          ::EacCli::Speaker.new(
            err_line_prefix(::EacRubyUtils::Speaker.context.optional_current
            .if_present('') { |v| v.is_a?(::EacCli::Speaker) ? v.err_line_prefix : '' } + '  ')
          )
        end
      end
    end
  end
end
