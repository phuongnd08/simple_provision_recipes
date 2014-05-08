#!/bin/bash
mkdir tmp
cd tmp
echo "2.1.1" >  .ruby-version

if ! which bundle > /dev/null; then
  gem install bundler
fi
