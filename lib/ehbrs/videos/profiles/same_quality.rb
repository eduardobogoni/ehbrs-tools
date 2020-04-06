# frozen_string_literal: true

require 'ehbrs/videos/profiles/base'

module Ehbrs
  module Videos
    module Profiles
      module SameQuality
        extend ::ActiveSupport::Concern

        included do
          include ::Ehbrs::Videos::Profiles::Base
        end

        def ffmpeg_args
          super + ['-q:a', '0', '-q:v', '0']
        end
      end
    end
  end
end
