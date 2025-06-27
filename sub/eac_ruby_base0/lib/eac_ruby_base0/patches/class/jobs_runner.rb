# frozen_string_literal: true

class Class
  def enable_jobs_runner
    ::EacRubyUtils.patch_module(self, ::EacRubyBase0::JobsRunner)
  end
end
