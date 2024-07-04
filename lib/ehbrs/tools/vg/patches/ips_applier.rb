# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/tools/executables'

module Ehbrs
  module Tools
    module Vg
      module Patches
        class IpsApplier
          common_constructor :patch_path

          # @param source_path [Pathname]
          # @param output_path [Pathname]
          # @raise [RuntimeError] Se o arquivo de saída não é criado.
          def apply(source_path, output_path)
            source_path = source_path.to_pathname
            output_path = output_path.to_pathname
            command(source_path, output_path).system!

            return if output_path.exist?

            fatal_error("Applier returned without error, but output file \"#{output_path}\"" \
                        'does not exist')
          end

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
