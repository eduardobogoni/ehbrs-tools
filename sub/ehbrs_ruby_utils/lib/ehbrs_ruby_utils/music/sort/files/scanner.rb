# frozen_string_literal: true

module EhbrsRubyUtils
  module Music
    module Sort
      module Files
        class Scanner
          enable_simple_cache
          common_constructor :root

          def all
            by_section.flat_map { |_s, fs| fs }
          end

          def config_file
            root.join('.sort')
          end

          # @return [Integer]
          def count
            by_section.values.inject(0) { |a, e| a + e.count }
          end

          def search(name)
            all.find { |sf| sf.name == name }
          end

          private

          def by_section_uncached
            r = {}
            to_sort.each do |f|
              sf = ::EhbrsRubyUtils::Music::Sort::Files::Factory.new(f, config_data).build
              r[sf.section] ||= []
              r[sf.section] << sf
            end
            EhbrsRubyUtils::Music::Sort::Files::Factory::SECTIONS.index_with do |s|
              r[s] || []
            end.freeze
          end

          def config_data_uncached
            if config_file.exist?
              ::EacRubyUtils::Yaml.load_file(config_file)
            else
              {}
            end
          end

          def to_sort
            root.children.reject { |e| e.basename.to_path.start_with?('.') }
          end
        end
      end
    end
  end
end
