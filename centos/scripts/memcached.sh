#!/bin/bash

if ! which memcached > /dev/null; then
  yum install memcached-devel -y
  chkconfig memcached on
  service memcached start
fi
