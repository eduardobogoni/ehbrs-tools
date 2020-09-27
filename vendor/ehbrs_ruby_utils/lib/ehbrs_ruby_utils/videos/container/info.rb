# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/videos/container/info'

module EhbrsRubyUtils
  module Videos
    module Container
      class Info
        enable_simple_cache
        common_constructor :ffprobe_data do
          self.ffprobe_data = ffprobe_data.with_indifferent_access.freeze
        end

        def to_h
          ffprobe_data
        end
      end
    end
  end
end
