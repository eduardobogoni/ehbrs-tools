# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

::Dir["#{::File.join(__dir__, 'sub')}/*"].each do |dir|
  next unless ::File.exist?(::File.join(dir, "#{::File.basename(dir)}.gemspec"))

  gem ::File.basename(dir), path: dir, require: false
end

local_gemfile = ::File.join(::File.dirname(__FILE__), 'Gemfile.local')
eval_gemfile local_gemfile if ::File.exist?(local_gemfile)
