#!/bin/sh

# ===========================================================
# Author:   Marcos Lin
# Created:  18 Dec 2018
#
# Script used execute each argument via `sh -c`, making it
# easier to run batch like commands via docker container.
#
# ===========================================================

for arg in "$@"
do
    echo "- $arg"
    /bin/sh -c "$arg"
    if [ "$?" -ne "0" ]; then
        echo "ERROR EXIT"
        exit 1
    fi
done
