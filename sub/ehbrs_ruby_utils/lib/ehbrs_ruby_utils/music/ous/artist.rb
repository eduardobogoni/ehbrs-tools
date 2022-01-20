# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/ous/category'
require 'ehbrs_ruby_utils/music/ous/node'

module EhbrsRubyUtils
  module Music
    module Ous
      class Artist < ::EhbrsRubyUtils::Music::Ous::Node
        def parent_node_class
          ::EhbrsRubyUtils::Music::Ous::Category
        end
      end
    end
  end
end
