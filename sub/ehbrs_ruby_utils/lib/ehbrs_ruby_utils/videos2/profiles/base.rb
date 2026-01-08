# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
    module Profiles
      module Base
        extend ::ActiveSupport::Concern

        attr_reader :convert_job

        included do
          include ActiveSupport::Callbacks

          define_callbacks :convert, :swap
        end

        def ffmpeg_args
          []
        end

        def on_convert_job
          old_value = convert_job
          begin
            yield
          ensure
            self.convert_job = old_value
          end
        end

        private

        attr_writer :convert_job
      end
    end
  end
end
