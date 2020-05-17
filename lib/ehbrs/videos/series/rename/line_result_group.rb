# frozen_string_literal: true

require_relative 'line_result'

module Ehbrs
  module Videos
    module Series
      module Rename
        class LineResultGroup < ::Ehbrs::Videos::Series::Rename::LineResult
          attr_reader :name, :children

          def initialize(name, files)
            @name = name
            @children = build_children(files)
          end

          def show(level)
            super(level)
            children.each do |child|
              child.show(level + 1)
            end
          end

          private

          def build_children(files)
            r = {}
            files.each do |file|
              key = file.send(child_key)
              r[key] ||= []
              r[key] << file
            end
            r.sort.map { |v| child_class.new(v[0], v[1]) }
          end
        end
      end
    end
  end
end
