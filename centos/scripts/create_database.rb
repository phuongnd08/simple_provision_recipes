#!/usr/bin/env ruby
TOKEN = "# Postgresql Autoconfigured"
CONFIG_FILE = "/var/lib/pgsql/9.3/data/pg_hba.conf"
if ENV['DB_NAME'].nil? || ENV['DB_NAME'].empty?
  puts %{Please set DB_NAME using env section inside your server config:
env:
  DB_NAME: your_db_name
  }

  raise "Error: DB_NAME is not defined"
end

str = `tail -1 #{CONFIG_FILE}`
unless str.strip == TOKEN
  lines = File.open(CONFIG_FILE).each.to_a
  lines.detect { |line| line.start_with?("local") }.sub!("peer", "trust")

  File.open(CONFIG_FILE, "w") do |f|
    lines.each do |line|
      f.puts line
    end
    f.puts TOKEN
  end

  system "service postgresql-9.3 restart"
end

# TODO: Check for database existence before trying to create
system %{
  echo -e "CREATE DATABASE #{ENV['DB_NAME']} WITH ENCODING 'unicode' TEMPLATE template0;\n\\q\n" | sudo -u postgres psql template1
}
