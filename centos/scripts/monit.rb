#!/usr/bin/env ruby

unless system("which monit > /dev/null")
  system("yum install monit -y")
end

system("chkconfig monit on")

unless `tail -1 /etc/monit.conf`.strip == "# Monit configured"
  File.open("/etc/monit.conf", "a") do |f|
    f.puts("set httpd port 2812 and")
    f.puts("    use address localhost  # only accept connection from localhost")
    f.puts("    allow localhost        # allow localhost to connect to the server and")
    f.puts("# Monit configured")
  end

  system("service monit restart")
end

