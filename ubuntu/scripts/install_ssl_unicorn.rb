#!/usr/bin/env ruby

require 'erb';

def increase_nginx_names_hash_bucket_size
  lines = File.open("/etc/nginx/nginx.conf").each.to_a
  return if lines.detect { |line| line.strip.start_with?("server_names_hash_bucket_size") }
  _, index = lines.each_with_index.detect { |line, index| line.strip.start_with?("http {") }
  lines.insert(index + 1, "  server_names_hash_bucket_size 64;")

  File.open("/etc/nginx/nginx.conf", "w") do |f|
    lines.each { |line| f.puts line }
  end
end

def remove_default_server_conf
  system "rm -f /etc/nginx/conf.d/default.conf"
end

def create_nginx_unicorn_conf
  File.open("/etc/nginx/conf.d/unicorn.conf", "w") do |f|
    f.puts ERB.new(File.open("files/nginx_ssl_unicorn.conf.erb").read).result
  end

  system("service nginx reload")
end

def create_initd_unicorn_script
  File.open("/etc/init.d/unicorn", "w") do |f|
    f.puts ERB.new(File.open("files/initd_unicorn.erb").read).result
  end

  system("chmod u+x /etc/init.d/unicorn")
end

def create_monit_unicorn_conf
  File.open("/etc/monit/conf.d/unicorn", "w") do |f|
    f.puts ERB.new(File.open("files/monit_unicorn.erb").read).result
  end

  system "/usr/sbin/update-rc.d -f unicorn defaults"
  system("service monit reload")
  system("monit restart unicorn")
end

def remove_default_site
  system "rm /etc/nginx/sites-enabled/default"
end

def copy_ssl_certs
  system "mkdir -p /root/certs/"
  # system "cp files/server.crt /root/certs/server.crt"
  # system "cp files/server.key /root/certs/server.key"
end

increase_nginx_names_hash_bucket_size
remove_default_server_conf
copy_ssl_certs
create_nginx_unicorn_conf
create_initd_unicorn_script
create_monit_unicorn_conf
remove_default_site
