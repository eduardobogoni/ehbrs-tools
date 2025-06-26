# frozen_string_literal: true

require 'eac_ruby_base0/jobs_runner'

class Class
  def enable_jobs_runner
    ::EacRubyUtils.patch_module(self, ::EacRubyBase0::JobsRunner)
  end
end
