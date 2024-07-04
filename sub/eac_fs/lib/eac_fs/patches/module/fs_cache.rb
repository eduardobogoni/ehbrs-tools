# frozen_string_literal: true

require 'eac_fs/contexts'

class Module
  ::EacFs::Contexts::TYPES.each do |type|
    method_name = "fs_#{type}"
    define_method method_name do
      ::EacFs::Contexts.send(type).current.child(method_name, *name.split('::'))
    end
  end
end
