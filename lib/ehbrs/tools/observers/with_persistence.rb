# frozen_string_literal: true

module Ehbrs
  module Tools
    module Observers
      class WithPersistence < ::Ehbrs::Tools::Observers::Base
        attr_reader :path

        def initialize(path, options = {})
          super(options)
          @path = path.to_pathname
          load
        end

        def check(value, date = ::Time.required_zone.now)
          save if super
        end

        def load
          save unless path.exist?
          data = ::YAML.load_file(path.to_path)
          @records = data.fetch(:records).map(&:to_struct)
          @last_check_time = data.fetch(:last_check_time)
        end

        def save
          path.parent.mkpath
          path.write({ records: records.map(&:to_h), last_check_time: last_check_time }.to_yaml)
        end
      end
    end
  end
end
