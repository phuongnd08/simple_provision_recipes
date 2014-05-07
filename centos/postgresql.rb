#!/usr/bin/env ruby

exit if system("which postgresql > /dev/null")

# Based on http://wiki.postgresql.org/wiki/YUM_Installation

lines = File.open("/etc/yum.repos.d/CentOS-Base.repo").each.to_a
index = lines.count - 1
while index >= 0 do
  if %w([base] [updates]).include? lines[index].strip
    lines.insert(index + 1, "exclude=postgresql*")
  end
  index -= 1
end

File.open("/etc/yum.repos.d/CentOS-Base.repo", "w") do |f|
  lines.each { |l| f.puts l }
end

system "yum localinstall http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm -y"
system "yum install postgresql93-server -y"
system "service postgresql-9.3 initdb"
system "chkconfig postgresql-9.3 on"
system "service postgresql-9.3 start"
