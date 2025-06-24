# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      class File < ::EhbrsRubyUtils::Videos::File
        include ::EhbrsRubyUtils::Videos2::Unsupported::CheckSupport
        include ::EhbrsRubyUtils::Videos2::Unsupported::File::Fix

        attr_reader :options

        def initialize(file, options)
          super(file)
          @options = options
        end

        def banner
          infov 'File', path
          pad_speaker do
            aggressions_banner('Self')
            tracks.each(&:banner)
          end
        end

        def all_passed?
          passed? && tracks.all?(&:passed?)
        end

        def all_fixes
          fixes + tracks.flat_map(&:fixes)
        end

        def check_set_key
          :file_check_set
        end

        private

        # @return [Enumerable<EhbrsRubyUtils::Videos2::Unsupported::Track>]
        def tracks_uncached
          streams.reject.map { |t| ::EhbrsRubyUtils::Videos2::Unsupported::Track.new(self, t) }
        end
      end
    end
  end
end
