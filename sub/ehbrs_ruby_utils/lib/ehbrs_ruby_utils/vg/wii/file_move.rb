# frozen_string_literal: true

require 'fileutils'

module EhbrsRubyUtils
  module Vg
    module Wii
      class FileMove
        common_constructor :game, :target do
          self.target = ::EhbrsRubyUtils::Vg::Wii::Wit::Path.assert(target)
        end

        ['', 'path_', 'type_'].each do |prefix|
          method_name = "#{prefix}change?"
          define_method(method_name) do
            source.send(method_name, target)
          end
        end

        def run
          [%w[path type], %w[path], %w[type]].each do |parts|
            next unless parts.all? { |part| send("#{part}_change?") }

            assert_target_dir
            send("change_#{parts.join('_and_')}")
            check_target
            break
          end
        end

        def source
          game.wit_path
        end

        private

        def assert_target_dir
          target.path.parent.mkpath
        end

        def change_path
          ::FileUtils.mv(source.path, target.path)
        end

        def change_path_and_type
          ::EhbrsRubyUtils::Executables.wit.command
            .append(change_path_and_type_args)
            .system!
          check_target
          source.path.unlink
        end

        def change_path_and_type_args
          r = %w[copy]
          target_image_format.if_present { |v| r << v.option }
          r + [source.path, target.path]
        end

        def change_type
          ::EhbrsRubyUtils::Executables.wit.command
            .append(change_type_args)
            .system!
        end

        def change_type_args
          r = %w[convert]
          target_image_format.if_present { |v| r << v.option }
          r + [target.path]
        end

        def check_target
          return if ::EhbrsRubyUtils::Vg::Wii::GameFile.new(target.path).valid?

          raise "Target \"#{target}\" is not a valid Wii game"
        end

        def target_image_format
          return nil if target.type.blank?

          ::EhbrsRubyUtils::Vg::Wii::Wit::ImageFormat.by_name(target.type)
        end
      end
    end
  end
end
