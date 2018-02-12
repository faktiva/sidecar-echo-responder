#!/bin/bash
#
# @author Emiliano Gabrielli <albert@faktiva.com>
# @license MIT

SERVER_IP="${SERVER_IP:-127.0.0.1}"
SERVER_PORT="${SERVER_PORT:-25}"
PING_STRING="${PING_STRING:-HELO example.test\nQUIT\n}"
TIMEOUT="${TIMEOUT:-3}"

printf "%s" "$PING_STRING" | nc -nvv -w "$TIMEOUT" "$SERVER_IP" "$SERVER_PORT"
