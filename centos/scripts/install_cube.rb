#!/usr/bin/env ruby
#!/usr/bin/env ruby

require 'erb';

# Check for unicorn init.d script. If exist, return
exit if File.exists?("/etc/monit.d/collector")

File.open("/etc/init.d/collector", "w") do |f|
  f.puts ERB.new(File.open("files/cube_collector.erb").read).result
end

File.open("/etc/init.d/evaluator", "w") do |f|
  f.puts ERB.new(File.open("files/cube_evaluator.erb").read).result
end

system("chmod u+x /etc/init.d/collector")
system("chmod u+x /etc/init.d/evaluator")
system("service collector reload")
system("service evaluator reload")

