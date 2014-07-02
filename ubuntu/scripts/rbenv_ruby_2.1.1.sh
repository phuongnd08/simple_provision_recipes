#!/bin/bash

RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/local/ssl rbenv install -s 2.1.1
rbenv global 2.1.1

# Rehash:
rbenv rehash

