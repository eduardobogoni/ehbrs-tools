# frozen_string_literal: true

require 'ehbrs/videos/unsupported/check_result'

module Ehbrs
  module Videos
    module Unsupported
      module CheckSupport
        extend ::ActiveSupport::Concern

        included do
          include ::EacRubyUtils::Console::Speaker
          include ::EacRubyUtils::SimpleCache
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
            check.check.fix.ffmpeg_args(self)
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
          checks.reject(&:passed?).map { |c| c.check.fix }.reject(&:blank?)
        end

        def pad_speaker
          on_speaker_node do |node|
            node.stderr_line_prefix = node.stderr_line_prefix.to_s + '  '
            yield
          end
        end
      end
    end
  end
end
