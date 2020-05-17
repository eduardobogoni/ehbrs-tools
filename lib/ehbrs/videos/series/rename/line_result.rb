# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Videos
    module Series
      module Rename
        class LineResult
          enable_simple_cache
          enable_console_speaker

          def show(level)
            out(padding_level(level) + line_out + "\n")
          end

          private

          def padding_level(level)
            ('  ' * level.to_i) + '* '
          end
        end
      end
    end
  end
end
