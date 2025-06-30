# frozen_string_literal: true

module Ehbrs
  module Self
    module Observers
      class WithPersistence
        enable_simple_cache
        common_constructor :label

        def check_current_value
          observer.check(current_value)
        end

        def changing_value?
          observer.changing_value?(current_value)
        end

        private

        def current_value_uncached
          calculate_value
        end

        def observer_uncached
          ::Ehbrs::Tools::Observers::WithPersistence.new(persistence_path, blank_value: :raise)
        end

        def persistence_path_uncached
          ::Ehbrs::UserDirs.data.child('observers', label.to_s.parameterize)
            .content_path.to_pathname
        end
      end
    end
  end
end
