#!/bin/bash
#
# @author Emiliano Gabrielli <albert@faktiva.com>
# @license MIT

SERVER_IP="${SERVER_IP:-127.0.0.1}"
SERVER_PORT="${SERVER_PORT:-25}"
PING_STRING="${PING_STRING:-QUIT}"
TIMEOUT="${TIMEOUT:-3}"

printf "%s\n" $PING_STRING | nc -n -w "$TIMEOUT" "$SERVER_IP" "$SERVER_PORT"
