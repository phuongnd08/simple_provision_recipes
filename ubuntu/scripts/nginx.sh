#!/bin/bash

if ! which nginx > /dev/null; then
  apt-get install nginx -y
  update-rc.d nginx defaults
  service nginx start
fi

