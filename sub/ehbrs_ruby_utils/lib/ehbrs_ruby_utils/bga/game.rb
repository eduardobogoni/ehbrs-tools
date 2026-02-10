# frozen_string_literal: true

module EhbrsRubyUtils
  module Bga
    class Game
      common_constructor :code, :name

      # @param suffix [String]
      # @return [EhbrsRubyUtils::Bga::Game::Image]
      def image(suffix)
        ::EhbrsRubyUtils::Bga::Game::Image.new(self, suffix)
      end

      {
        publisher: '/publisher/0.png',
        banner_medium: '/banner/default_500.jpg',
        banner_large: '/banner/default.jpg',
        box_small: '/box/en_75.png',
        box_medium: '/box/en_180.png',
        box_large: '/box/en_280.png',
        title_medium: '/title/en_500.png',
        title_large: '/title/en_2000.png'
      }.each do |k, suffix|
        define_method "#{k}_image" do
          image(suffix)
        end
      end

      # @param nth [Integer]
      # @return [Addressable::URI]
      def display_image(nth)
        image("/display/#{nth}.jpg")
      end
    end
  end
end
