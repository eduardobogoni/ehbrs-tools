# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/tools/runner/videos/languages/labelized'

module Ehbrs
  module Tools
    class Runner
      class Videos
        class Languages
          class Language < ::Ehbrs::Tools::Runner::Videos::Languages::Labelized
            def to_s
              __getobj__
            end

            def language
              __getobj__
            end
          end
        end
      end
    end
  end
end
