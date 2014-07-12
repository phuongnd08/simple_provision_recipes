#!/bin/bash

ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts
