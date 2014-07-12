#!/usr/bin/env ruby

require 'erb';

# Check for unicorn init.d script. If exist, return
exit if File.exists?("/etc/monit/conf.d/sidekiq")

File.open("/etc/init.d/sidekiq", "w") do |f|
  f.puts ERB.new(File.open("files/initd_sidekiq.erb").read).result
end

# Create monit configuration to watch for unicorn

File.open("/etc/monit/conf.d/sidekiq", "w") do |f|
  f.puts ERB.new(File.open("files/monit_sidekiq.erb").read).result
end

system("chmod u+x /etc/monit/conf.d/sidekiq")
system("service monit reload")

