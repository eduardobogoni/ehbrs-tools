# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  class CircularListSpreader
    require_sub __FILE__
    common_constructor :items

    # @return [Array]
    def result
      root_level = ::EhbrsRubyUtils::CircularListSpreader::GroupLevel.new('ROOT')
      items.each { |item| root_level.push(item.to_spreader_t1_path, item) }
      root_level.pop_all
    end
  end
end
