# frozen_string_literal: true

require 'ehbrs/videos/file'
require 'ehbrs/videos/unsupported/file/fix'
require 'ehbrs/videos/unsupported/check_support'
require 'ehbrs/videos/unsupported/track'

module Ehbrs
  module Videos
    module Unsupported
      class File < ::Ehbrs::Videos::File
        include ::Ehbrs::Videos::Unsupported::CheckSupport
        include ::Ehbrs::Videos::Unsupported::File::Fix

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

        def tracks_uncached
          super.map { |t| ::Ehbrs::Videos::Unsupported::Track.new(self, t) }
        end
      end
    end
  end
end
