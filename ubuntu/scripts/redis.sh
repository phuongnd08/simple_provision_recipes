#!/bin/bash
if ! which redis-server > /dev/null; then
  yum -y install make gcc cc

  pushd /tmp
    rm -rf redis-2.6.16
    curl -O http://download.redis.io/releases/redis-2.6.16.tar.gz
    tar zxvf redis-2.6.16.tar.gz
    cd redis-2.6.16
    make
    cp src/redis-server /usr/local/bin
    cp src/redis-cli /usr/local/bin
    cp redis.conf /etc/redis.conf
    sed -i 's/daemonize no/daemonize yes/g' /etc/redis.conf > /dev/null
  popd

  cp files/initd_redis /etc/init.d/redis
  chmod u+x /etc/init.d/redis
  update-rc.d redis defaults
  service redis start
fi
