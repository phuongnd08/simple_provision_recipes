#!/usr/bin/env ruby

unless system("which monit > /dev/null")
  system("apt-get install monit -y")
end

system("update-rc.d monit defaults")

def config_monit_daemon
  unless system("grep -q '^set httpd port 2812 and' /etc/monit/monitrc")
    File.open("/etc/monit/monitrc", "a") do |f|
      f.puts("set httpd port 2812 and")
      f.puts("    use address localhost  # only accept connection from localhost")
      f.puts("    allow localhost        # allow localhost to connect to the server and")
      f.puts("# monit configured")
    end

    system("service monit restart")
  end
end

config_monit_daemon
