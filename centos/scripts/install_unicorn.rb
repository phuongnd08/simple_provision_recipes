#!/usr/bin/env ruby

# Check for unicorn init.d script. If exist, return
# Create unicorn init.d script based on erb files and environment params
# Create SSL certs based on files
#   These SSL should be copied from Dropbox, outside of the app repo
# Create nginx configuration to load unicorn app
# Create monit configuration to load watch for unicorn
