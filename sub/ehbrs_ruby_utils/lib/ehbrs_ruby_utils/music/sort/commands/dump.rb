# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/music/sort/commands/base'
require 'ehbrs_ruby_utils/music/sort/files/base'
require 'ehbrs_ruby_utils/music/sort/files/factory'

module EhbrsRubyUtils
  module Music
    module Sort
      module Commands
        class Dump < EhbrsRubyUtils::Music::Sort::Commands::Base
          private

          def run
            if File.exist?(config_file)
              @config = YAML.load_file(config_file)
              to_rename.each { |sf| rename(sf) }
            else
              fatal_error("File \"#{config_file}\" does not exist")
            end
          end

          def to_rename
            r = []
            ::EhbrsRubyUtils::Music::Sort::Files::Factory::SECTIONS.each do |section|
              i = 1
              (@config[section] || []).each do |name|
                r << ::EhbrsRubyUtils::Music::Sort::Files::Base.new(section, i, name, nil)
                i += 1
              end
            end
            r
          end

          def rename(source_file)
            o = scanner.search(source_file.name)
            if o
              rename_on_found(source_file, o)
            else
              warn("File not found for \"#{source_file}\"")
            end
          end

          def rename_on_found(source_file, sorted_file)
            o = sorted_file.reorder(source_file.section, source_file.order, order_padding)
            info("\"#{o.source_basename}\" => \"#{o.target_basename}\"")
            confirm_rename(o.source_basename, o.target_basename) if confirm
          end

          def confirm_rename(old_basename, new_basename)
            op = File.expand_path(old_basename, root)
            np = File.expand_path(new_basename, root)
            return if np == op
            raise "\"#{np}\" (From \"#{op}\") already exists" if File.exist?(np)

            File.rename(op, np)
          end

          def order_padding_uncached
            scanner.count.to_s.length
          end
        end
      end
    end
  end
end
