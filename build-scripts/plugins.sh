#!/bin/bash
for D in */; do
    if [ -d "${D}" ]; then
        cd "${D}"
        echo "Installing $D"
        composer update --lock
        composer install --no-dev
        cd ..
    fi
done