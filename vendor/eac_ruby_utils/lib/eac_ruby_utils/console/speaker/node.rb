# frozen_string_literal: true

require 'eac_ruby_utils/patches/object/if_present'

module EacRubyUtils
  module Console
    module Speaker
      class Node
        attr_accessor :stdin, :stdout, :stderr, :stderr_line_prefix

        def initialize(parent = nil)
          self.stdin = parent.if_present(STDIN, &:stdin)
          self.stdout = parent.if_present(STDOUT, &:stdout)
          self.stderr = parent.if_present(STDERR, &:stderr)
          self.stderr_line_prefix = parent.if_present('', &:stderr_line_prefix)
        end

        def configure
          yield(self)
          self
        end
      end
    end
  end
end