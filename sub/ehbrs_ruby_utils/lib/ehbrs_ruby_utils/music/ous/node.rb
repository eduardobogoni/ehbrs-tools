# frozen_string_literal: true

module EhbrsRubyUtils
  module Music
    module Ous
      class Node
        DEFAULT_LANGUAGE = 'unk'
        LANGUAGE_FILE_BASENAME = '.language'

        enable_simple_cache
        common_constructor :path do
          self.path = path.to_pathname.expand_path
        end

        def name
          real_path.basename.to_s
        end

        def language
          self_language || parent_language || DEFAULT_LANGUAGE
        end

        def language_file
          path.join(LANGUAGE_FILE_BASENAME)
        end

        def parent_language
          parent_node.if_present(&:language)
        end

        def real_path
          path.readlink_r
        end

        def self_language
          language_file.if_exist('', &:read).strip.presence
        end

        def to_s
          name
        end

        private

        def parent_node_uncached
          parent_node_class.if_present { |v| v.new(real_path.parent) }
        end
      end
    end
  end
end
