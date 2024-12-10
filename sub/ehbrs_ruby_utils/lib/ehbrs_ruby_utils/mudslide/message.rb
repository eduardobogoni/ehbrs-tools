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
        r = ::EhbrsRubyUtils::Executables.mudslide.command(*args).execute
        raise_mudslide_run_error r, 'exit code not zero ' unless r.fetch(:exit_code).zero?
        raise_mudslide_run_error r, 'blank stdout' if r.fetch(:stdout).blank?
        raise_mudslide_run_error r, 'qrcode shown' if r.fetch(:stdout).include?('▄▄▄▄▄▄▄▄▄')
      end

      def raise_mudslide_run_error(result, reason)
        raise result.merge(reason: reason).pretty_inspect
      end
    end
  end
end
