# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacDocker
  module Rspec
    class StubImage
      include ::ActiveSupport::Callbacks
      define_callbacks :on_container
      common_constructor :image

      def build_container
        image.provide.container.temporary(true)
      end

      def container
        raise 'internal container is blank' if internal_container.blank?

        internal_container
      end

      def on_container(&block)
        raise 'A container was already created' if internal_container.present?

        build_container.on_detached do |container|
          self.internal_container = container
          begin
            run_callbacks(:on_container, &block)
          ensure
            self.internal_container = nil
          end
        end
      end

      private

      attr_accessor :internal_container
    end
  end
end
