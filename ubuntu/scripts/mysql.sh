#!/bin/bash

if ! which mysql > /dev/null; then
  apt-get install mysql-server -y
  service mysql start
fi

