# frozen_string_literal: true

require 'ehbrs/music/album'
require 'ehbrs/tools/runner/fs/selected'

module Ehbrs
  module Tools
    class Runner
      class Music
        class Selected < ::Ehbrs::Tools::Runner::Fs::Selected
          protected

          def build_selected_directory(path)
            ::Ehbrs::Music::Album.new(path)
          end

          def directory_label(directory)
            directory.to_label
          end

          def directory_target_basename(directory)
            directory.id
          end
        end
      end
    end
  end
end
