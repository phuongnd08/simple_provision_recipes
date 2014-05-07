#!/bin/bash
if ! which git > /dev/null; then
  yum install git -y
fi
