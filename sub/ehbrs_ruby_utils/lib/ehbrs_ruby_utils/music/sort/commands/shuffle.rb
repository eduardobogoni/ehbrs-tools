# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/sort/commands/base'
require 'ehbrs_ruby_utils/music/sort/files/factory'

module EhbrsRubyUtils
  module Music
    module Sort
      module Commands
        class Shuffle < EhbrsRubyUtils::Music::Sort::Commands::Base
          private

          def run
            if confirm
              load_last_shuffle
            else
              dump_last_shuffle
            end
          end

          def dump_last_shuffle
            s = build_config.to_yaml
            puts s
            info("Writing to \"#{last_shuffle_file}\"...")
            File.write(last_shuffle_file, s)
            puts 'Done!'.green
          end

          def load_last_shuffle
            if File.exist?(last_shuffle_file)
              IO.copy_stream(last_shuffle_file, config_file)
              File.unlink(last_shuffle_file)
              puts 'Done!'.green
            else
              fatal_error "File \"#{last_shuffle_file}\" does not exist"
            end
          end

          def last_shuffle_file
            File.join(root, '.last_shuffle')
          end

          def build_config
            config = {}
            config[::EhbrsRubyUtils::Music::Sort::Files::Factory::SECTION_CURRENT] =
              scanner.all.to_a.shuffle.map(&:name)
            config[::EhbrsRubyUtils::Music::Sort::Files::Factory::SECTION_NEW] = []
            config
          end
        end
      end
    end
  end
end
