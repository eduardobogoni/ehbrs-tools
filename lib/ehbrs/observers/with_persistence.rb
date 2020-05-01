# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs/observers/base'

module Ehbrs
  module Observers
    class WithPersistence < ::Ehbrs::Observers::Base
      attr_reader :path

      def initialize(path, options = {})
        super(options)
        @path = path.to_pathname
        load
      end

      def check(value, date = ::Time.zone.now)
        save if super(value, date)
      end

      def load
        save unless path.exist?
        data = ::YAML.load_file(path.to_path)
        @records = data.fetch(:records).map { |h| ::OpenStruct.new(h) }
        @last_check_time = data.fetch(:last_check_time)
      end

      def save
        path.parent.mkpath
        path.write({ records: records.map(&:to_h), last_check_time: last_check_time }.to_yaml)
      end
    end
  end
end
