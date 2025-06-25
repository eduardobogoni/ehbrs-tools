# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Patchers
      class VcdiffApplier < ::EhbrsRubyUtils::Vg::Patchers::BaseApplier
        # @param source_path [Pathname]
        # @param output_path [Pathname]
        # @return [EacRubyUtils::Envs::Command]
        def command(source_path, output_path)
          ::EhbrsRubyUtils::Executables.xdelta3.command
            .append(['-d', '-s', source_path, patch_path, output_path])
        end
      end
    end
  end
end
