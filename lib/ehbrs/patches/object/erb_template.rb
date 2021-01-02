# frozen_string_literal: true

require 'ehbrs/patches/module/erb_template'

class Object
  def erb_template(subpath, binding_obj = self)
    self.class.erb_template(subpath, binding_obj)
  end
end
