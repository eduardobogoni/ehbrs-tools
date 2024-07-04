# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/tools/executables'
require 'ehbrs/tools/vg/patches/base_applier'

module Ehbrs
  module Tools
    module Vg
      module Patches
        class VcdiffApplier < ::Ehbrs::Tools::Vg::Patches::BaseApplier
          # @param source_path [Pathname]
          # @param output_path [Pathname]
          # @return [EacRubyUtils::Envs::Command]
          def command(source_path, output_path)
            ::Ehbrs::Tools::Executables.xdelta3.command
              .append(['-d', '-s', source_path, patch_path, output_path])
          end
        end
      end
    end
  end
end
