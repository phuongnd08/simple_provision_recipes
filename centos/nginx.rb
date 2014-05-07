#!/usr/bin/env ruby

exit if system("which nginx > /dev/null")
unless File.exists?("/etc/yum.repos.d/nginx.repo")
  File.open("/etc/yum.repos.d/nginx.repo", "w") do |f|
    f.puts "[epel]"
    f.puts "name=For Redis"
    f.puts "baseurl=http://dl.fedoraproject.org/pub/epel/6/x86_64/"
    f.puts "ienabled=1"
    f.puts "gpgcheck=0"
  end
end

system("yum install nginx -y")
system("chkconfig nginx on")
system("service nginx start")
