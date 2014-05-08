#!/bin/bash
if ! which redis-server > /dev/null; then
  yum -y install make gcc cc

  mkdir tmp
  cd tmp

  curl -O http://download.redis.io/releases/redis-2.6.16.tar.gz
  tar zxvf redis-2.6.16.tar.gz
  cd redis-2.6.16
  make
  cp src/redis-server /usr/local/bin
  cp src/redis-cli /usr/local/bin
  cp ../../files/initd_redis /etc/init.d/redis
  chmod u+x /etc/init.d/redis
  cp redis.conf /etc/redis.conf
  sed -i 's/daemonize no/daemonize yes/g' /etc/redis.conf > /dev/null
  chkconfig --add redis
  chkconfig redis on
  service redis start
fi
