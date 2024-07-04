# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Tools
    module Vg
      module Patches
        class TempFiles
          common_constructor :initial, :temp0, :temp1

          def input
            swaped? ? temp0 : initial
          end

          def move_result_to(dest)
            return unless swaped?

            ::FileUtils.mv(temp0.to_path, dest.to_path)
          end

          def output
            temp1
          end

          def swap
            temp0_current = temp0
            self.temp0 = temp1
            self.temp1 = temp0_current
            @swaped = true
          end

          def swaped?
            @swaped ? true : false
          end
        end
      end
    end
  end
end
