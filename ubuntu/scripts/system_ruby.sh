#!/bin/bash
if ! which ruby > /dev/null; then
  apt-get install ruby -y
fi
