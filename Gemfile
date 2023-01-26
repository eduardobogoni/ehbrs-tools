# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

::Dir["#{::File.join(__dir__, 'sub')}/*"].each do |dir|
  next unless ::File.exist?(::File.join(dir, "#{::File.basename(dir)}.gemspec"))

  gem ::File.basename(dir), path: dir, require: false
end

gem 'httpclient', git: 'https://github.com/livelink/httpclient.git'
