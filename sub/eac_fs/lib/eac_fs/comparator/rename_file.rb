# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacFs
  class Comparator
    class RenameFile
      common_constructor :from, :to

      def apply(basename)
        basename == from ? to : basename
      end
    end
  end
end
