#!/bin/bash

# check for curl
if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using: apt install curl"
  exit 1
fi

# dectect for errors 