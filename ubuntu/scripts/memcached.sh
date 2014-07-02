#!/bin/bash

if ! which memcached > /dev/null; then
  apt-get install memcached -y
  update-rc.d memcached defaults
  service memcached start
fi
