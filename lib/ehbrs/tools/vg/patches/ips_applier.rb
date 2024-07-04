# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/tools/executables'
require 'ehbrs/tools/vg/patches/base_applier'

module Ehbrs
  module Tools
    module Vg
      module Patches
        class IpsApplier < ::Ehbrs::Tools::Vg::Patches::BaseApplier
          # @param source_path [Pathname]
          # @param output_path [Pathname]
          # @return [EacRubyUtils::Envs::Command]
          def command(source_path, output_path)
            ::Ehbrs::Tools::Executables.flips.command
              .append(['--apply', patch_path, source_path, output_path])
          end
        end
      end
    end
  end
end
