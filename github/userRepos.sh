#!/bin/bash

#for URL in $(curl -s https://api.github.com/users/felipem775/repos | awk -F "\"" '/clone/{print $4}'); do git clone $URL; done

if [ -z "$1" ]
  then
    echo "Username?"
    exit 1
fi
curl -s https://api.github.com/users/$1/repos| awk -F "\"" '/clone/{print $4}' |xargs -n 1 git clone 
