# frozen_string_literal: true

module EhbrsRubyUtils
  module Music
    module Sort
      module Files
        class Base
          common_constructor :section, :order, :name, :original_path, :padding, default: [nil, 0] do
            self.original_path = original_path.if_present { |v| v.to_pathname.expand_path }
          end

          def reorder(new_section, new_order, padding)
            self.class.new(new_section, new_order, name, original_path, padding)
          end

          def target_basename
            "#{section}#{order.to_s.rjust(padding, '0')} #{name}"
          end

          def source_basename
            original_path.if_present(&:basename) || raise('Original path is blank')
          end

          def to_s
            target_basename
          end

          private

          def <=>(other)
            %i[section order name].each do |a|
              r = send(a) <=> other.send(a)
              return r unless r.zero?
            end
            0
          end
        end
      end
    end
  end
end
