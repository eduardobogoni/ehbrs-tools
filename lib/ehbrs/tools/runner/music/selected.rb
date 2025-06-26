# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Music
        class Selected < ::Ehbrs::Tools::Runner::Fs::Selected
          protected

          def directory_label(directory)
            path_to_album(directory).to_label
          end

          def directory_target_basename(directory)
            path_to_album(directory).id
          end

          def path_to_album(path)
            ::EhbrsRubyUtils::Music::Ous::Album.new(path)
          end
        end
      end
    end
  end
end
