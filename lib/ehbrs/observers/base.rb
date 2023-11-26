# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Ehbrs
  module Observers
    class Base
      include ::EacRubyUtils::Listable

      lists.add_string :blank_value, :add, :ignore, :raise

      attr_reader :records, :blank_value, :last_check_time

      common_constructor :options, default: [{}] do
        @records = options[:records] || []
        @blank_value = options[:blank_value].if_present(BLANK_VALUE_ADD) do |v|
          v = v.to_s
          ::Ehbrs::Observers::Base.lists.blank_value.value_validate!(v)
          v
        end
      end

      def check(value, date = ::Time.required_zone.now)
        @last_check_time = date
        send("check_with_blank_value_#{blank_value}", value, date)
      end

      def changing_value?(value)
        records.if_present(true) do
          last_value.if_present(value.present?) { |v| v != value }
        end
      end

      def last_change_time
        records.last.if_present(&:time)
      end

      def last_value
        records.last.if_present(&:value)
      end

      private

      def check_with_blank_value_add(value, time)
        return false unless changing_value?(value)

        records << { value: value, time: time }.to_struct
        true
      end

      def check_with_blank_value_ignore(value, date)
        false if value.blank? ? false : check_with_blank_value_add(value, date)
      end

      def check_with_blank_value_raise(value, date)
        raise(::ArgumentError, "Blank value checked (Value: #{value}, Class: #{value.class})") if
        value.blank?

        check_with_blank_value_add(value, date)
      end
    end
  end
end
