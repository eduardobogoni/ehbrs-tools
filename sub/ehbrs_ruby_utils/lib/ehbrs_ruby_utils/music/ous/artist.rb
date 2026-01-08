# frozen_string_literal: true

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
