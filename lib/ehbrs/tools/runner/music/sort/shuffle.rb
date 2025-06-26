# frozen_string_literal: true

module Ehbrs
  module Tools
    class Runner
      class Music
        class Sort
          class Shuffle
            runner_with :help do
              bool_opt '-l', '--load'
            end

            def run
              if parsed.load?
                load_last_shuffle
              else
                dump_last_shuffle
              end
            end

            private

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
              File.join(path, '.last_shuffle')
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
end
