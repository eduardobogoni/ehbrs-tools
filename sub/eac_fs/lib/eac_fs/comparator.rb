# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacFs
  class Comparator
    require_sub __FILE__, require_dependency: true

    enable_immutable
    immutable_accessor :rename_file, :truncate_file, type: :array

    alias rename_file_push rename_file

    def rename_file(from, to)
      rename_file_push(::EacFs::Comparator::RenameFile.new(from, to))
    end
  end
end
