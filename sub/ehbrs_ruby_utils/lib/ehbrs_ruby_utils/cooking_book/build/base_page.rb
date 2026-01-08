# frozen_string_literal: true

module EhbrsRubyUtils
  module CookingBook
    class Build
      class BasePage < SimpleDelegator
        attr_reader :parent

        def initialize(parent, source_object)
          super(source_object)
          @parent = parent
        end

        def build
          target_path.write(target_content)
        end

        def href
          "#{target_basename}.html"
        end

        def target_path
          parent.target_dir.join(href)
        end

        def target_content
          erb_result('layout', ::EhbrsRubyUtils::CookingBook::Build::BasePage)
        end

        def inner_content
          erb_result('inner', self.class)
        end

        def erb_result(template_basename, template_source = self)
          template_source.erb_template("#{template_basename}.html.erb", self)
        end
      end
    end
  end
end
