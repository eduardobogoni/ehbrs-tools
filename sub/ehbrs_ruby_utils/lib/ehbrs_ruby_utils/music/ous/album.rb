# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/ous/artist'
require 'ehbrs_ruby_utils/music/ous/node'

module EhbrsRubyUtils
  module Music
    module Ous
      class Album < ::EhbrsRubyUtils::Music::Ous::Node
        include ::Comparable

        def <=>(other)
          to_a <=> other.to_a
        end

        def to_a
          [language, category.name, artist.name, name]
        end

        def to_spreader_t1_path
          to_a
        end

        def to_label
          (to_a + [id]).map(&:light_white).join(' | '.blue)
        end

        delegate :to_path, to: :path

        def id
          [artist.name, name].join('_').variableize
        end

        # @return [EhbrsRubyUtils::Music::Ous::Artist]
        def artist
          parent_node
        end

        def category
          artist.parent_node
        end

        def parent_node_class
          ::EhbrsRubyUtils::Music::Ous::Artist
        end
      end
    end
  end
end
