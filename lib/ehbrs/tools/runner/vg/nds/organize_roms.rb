# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Vg
        class Nds
          class OrganizeRoms
            runner_with :confirmation, :help do
              pos_arg :roms_root
            end

            delegate :roms_root, to: :parsed

            def run
              start_banner
              organizer.perform_all
            end

            def show?
              true
            end

            protected

            # @return [FileManager]
            def organizer_uncached
              ::EhbrsRubyUtils::Vg::Nds::Organizer.new(self)
            end

            # @return [void]
            def start_banner
              infov 'Roms root', roms_root
            end
          end
        end
      end
    end
  end
end
