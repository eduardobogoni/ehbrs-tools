# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/ous/node'

module EhbrsRubyUtils
  module Music
    module Ous
      class Category < ::EhbrsRubyUtils::Music::Ous::Node
        def parent_node_class
          nil
        end
      end
    end
  end
end
