#!/bin/bash
if ! which ruby > /dev/null; then
  yum install ruby -y
fi
