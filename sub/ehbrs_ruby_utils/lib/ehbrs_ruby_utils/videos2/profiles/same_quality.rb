# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos2/profiles/base'

module EhbrsRubyUtils
  module Videos2
    module Profiles
      module SameQuality
        extend ::ActiveSupport::Concern

        included do
          include ::EhbrsRubyUtils::Videos2::Profiles::Base
        end

        def ffmpeg_args
          super + ['-q:a', '0', '-q:v', '0']
        end
      end
    end
  end
end
