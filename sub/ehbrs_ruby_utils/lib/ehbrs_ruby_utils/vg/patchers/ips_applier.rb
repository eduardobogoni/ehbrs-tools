# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Patchers
      class IpsApplier < ::EhbrsRubyUtils::Vg::Patchers::BaseApplier
        # @param source_path [Pathname]
        # @param output_path [Pathname]
        # @return [EacRubyUtils::Envs::Command]
        def command(source_path, output_path)
          ::EhbrsRubyUtils::Executables.flips.command
            .append(['--apply', patch_path, source_path, output_path])
        end
      end
    end
  end
end
