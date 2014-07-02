#!/usr/bin/env ruby
require 'erb';

command = "mysql -u#{ENV["DB_USERNAME"]} -p#{ENV["DB_PASSWORD"]} -e 'CREATE DATABASE IF NOT EXISTS #{ENV["DB_NAME"]} DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;'"
system command
