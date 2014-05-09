#!/usr/bin/env ruby

require 'erb';

# Check for unicorn init.d script. If exist, return
exit if File.exists?("/etc/monit.d/unicorn")

# Create nginx configuration to load unicorn app
## First increase nginx server_names_hash_bucket_size

lines = File.open("/etc/nginx/nginx.conf").each.to_a
_, index = lines.each_with_index.detect { |line, index| line.strip.start_with?("http {") }
lines.insert(index + 1, "  server_names_hash_bucket_size 64;")

File.open("/etc/nginx/nginx.conf", "w") do |f|
  lines.each { |line| f.puts line }
end

File.open("/etc/nginx/conf.d/unicorn.conf", "w") do |f|
  f.puts ERB.new(File.open("files/nginx_unicorn.conf.erb").read).result
end

# Create SSL certs based on files
#   These SSL should be copied from Dropbox, outside of the app repo
#
# Create unicorn init.d script based on erb files and environment params

File.open("/etc/init.d/unicorn", "w") do |f|
  f.puts ERB.new(File.open("files/initd_unicorn.erb").read).result
end

# Create monit configuration to watch for unicorn

File.open("/etc/monit.d/unicorn", "w") do |f|
  f.puts ERB.new(File.open("files/monit_unicorn.erb").read).result
end

system("chmod u+x /etc/init.d/unicorn")
system("monit reload")
