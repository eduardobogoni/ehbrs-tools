# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Music
    module Ous
      class Album
        include ::Comparable
        common_constructor :path do
          self.path = path.to_pathname.expand_path
        end

        def <=>(other)
          to_a <=> other.to_a
        end

        def to_a
          [category, artist, name]
        end

        def to_label
          (to_a + [id]).map(&:light_white).join(' | '.blue)
        end

        delegate :to_path, to: :path

        def id
          [artist, name].join('_').variableize
        end

        def name
          path.basename.to_s
        end

        def artist
          path.parent.basename.to_s
        end

        def category
          path.parent.parent.basename.to_s
        end
      end
    end
  end
end
