#!/usr/bin/env ruby
def swap_count
  swap = `swapon -s`
  swap.split("\n").length - 1
end

if swap_count == 0
  system("sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k")
  system("sudo mkswap /swapfile")
  system("sudo swapon /swapfile")
  system("echo '/swapfile          swap            swap    defaults        0 0' >> /etc/fstab")
  system("chown root:root /swapfile")
  system("chmod 0600 /swapfile")
  system("echo 'vm.swappiness=10' >> /etc/sysctl.conf")
end
