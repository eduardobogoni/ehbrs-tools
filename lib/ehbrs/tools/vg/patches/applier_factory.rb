# frozen_string_literal: true

require 'eac_fs/core_ext'
require 'ehbrs/tools/vg/patches/ips_applier'
require 'ehbrs/tools/vg/patches/vcdiff_applier'

module Ehbrs
  module Tools
    module Vg
      module Patches
        class ApplierFactory
          APPLIERS_BY_TYPE = {
            'IPS patch file' => ::Ehbrs::Tools::Vg::Patches::IpsApplier,
            'VCDIFF binary diff' => ::Ehbrs::Tools::Vg::Patches::VcdiffApplier
          }.freeze

          enable_simple_cache
          common_constructor :patch_path do
            self.patch_path = patch_path.to_pathname
          end
          delegate :apply, to: :applier_instance

          # @return [String]
          def patch_type
            patch_path.info.description
          end

          protected

          # @return [Class]
          def applier_class_uncached
            APPLIERS_BY_TYPE.fetch(patch_type)
          end

          # @return [Object]
          def applier_instance_uncached
            applier_class.new(patch_path)
          end
        end
      end
    end
  end
end
