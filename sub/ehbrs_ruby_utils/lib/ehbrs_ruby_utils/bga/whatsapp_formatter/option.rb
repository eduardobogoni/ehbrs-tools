# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    module WhatsappFormatter
      class Option
        class << self
          # @param obj [Object]
          # @return [EhbrsRubyUtils::Bga::WhatsappFormatter::Option]
          def assert(obj)
            return obj if obj.is_a?(self)
            return new(obj.label, obj.value) if obj.respond_to?(:label) && obj.respond_to?(:value)
            return new(obj.fetch(:label), obj.fetch(:value)) if obj.is_a?(::Hash)
            return new(*obj) if obj.is_a?(::Enumerable)

            raise(::ArgumentError, "\"#{obj}\" não pôde ser convertido para #{self}")
          end
        end

        common_constructor :label, :value

        # @return [String]
        def to_s
          "*#{label}:* #{value}"
        end
      end
    end
  end
end
