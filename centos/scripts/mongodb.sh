#!/bin/bash
if ! which mongo > /dev/null; then
  yum -y install mongodb mongodb-server
  chkconfig mongod on
  service mongod start
fi

