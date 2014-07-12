#!/bin/bash
if ! which mongo > /dev/null; then
  apt-get -y install mongodb mongodb-server
  update-rc.d mongod defaults
  service mongod start
fi

