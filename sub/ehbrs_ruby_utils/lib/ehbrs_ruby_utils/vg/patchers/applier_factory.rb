# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Patchers
      class ApplierFactory
        APPLIERS_BY_TYPE = {
          'BPS patch file' => ::EhbrsRubyUtils::Vg::Patchers::BpsApplier,
          'IPS patch file' => ::EhbrsRubyUtils::Vg::Patchers::IpsApplier,
          'VCDIFF binary diff' => ::EhbrsRubyUtils::Vg::Patchers::VcdiffApplier
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
