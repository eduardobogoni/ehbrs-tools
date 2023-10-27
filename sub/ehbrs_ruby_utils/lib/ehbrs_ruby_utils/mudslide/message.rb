# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/executables'

module EhbrsRubyUtils
  module Mudslide
    class Message
      acts_as_immutable
      immutable_accessor :image_path, :recipient, :text

      def deliver
        raise 'No recipient set' if recipient.blank?

        if image_path.present?
          deliver_image
        elsif text.present?
          deliver_text
        else
          deliver
        end
      end

      private

      # @return [void]
      def deliver_image
        args = ['send-image']
        text.if_present { |_v| args += ['--caption', text] }
        mudslide_run(*args, recipient, image_path)
      end

      # @return [void]
      def deliver_text
        mudslide_run('send', recipient, text)
      end

      # @return [void]
      def mudslide_run(*args)
        ::EhbrsRubyUtils::Executables.mudslide.command(*args).system!
      end
    end
  end
end
