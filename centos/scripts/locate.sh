#!/bin/bash
if ! which locate > /dev/null; then
  yum install mlocate -y
  updatedb
fi
