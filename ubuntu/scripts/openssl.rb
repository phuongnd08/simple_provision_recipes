#!/usr/bin/env ruby

open_ssl_version = `openssl version | head -1`

# unless open_ssl_version.include?("1.0.1g")
unless File.exist?("/tmp/openssl-1.0.1g.tar.gz")
  shell = %{
    cd /tmp
    curl -O https://www.openssl.org/source/openssl-1.0.1g.tar.gz
    tar -xzf openssl-1.0.1g.tar.gz
    cd openssl-1.0.1g
    CFLAGS=-fPIC ./config shared
    make
    make install
  }

  system shell

  unless File.exist?("/usr/lib64/libssl.so")
    `mkdir /usr/lib64/ -p
    ln -s /usr/local/ssl/lib/libssl.so /usr/lib64/libssl.so`
  end
end

unless File.read("/root/.bashrc").include?("PATH=/usr/local/ssl/bin")
  File.open("/root/.bashrc", "a") do |f|
    f.puts "export PATH=/usr/local/ssl/bin:$PATH"
  end
end
