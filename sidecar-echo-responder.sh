#!/bin/bash
#
# @author Emiliano Gabrielli <albert@faktiva.com>
# @license MIT
#
# The default is to check an SMTP server on port 25 of the localhost.
# In case adjust this script to pass the the required values to the PING_BIN,
# simply export the required variables with the adjusted values

set -e -o pipefail

DEBUG="${DEBUG}"
PONG_PORT="${PONG_PORT:-6666}"
PING_BIN="${PING_BIN:-service-ping.sh}"

while /bin/true ; do
    nc -nl -p "$PONG_PORT" -e "$PING_BIN"
    if [ "$DEBUG" ]; then
        echo $?
    fi
done
