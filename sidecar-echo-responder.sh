#!/bin/bash
#
# @author Emiliano Gabrielli <albert@faktiva.com>
# @license MIT
#
# The default is to check an SMTP server on port 25 of the localhost.
# In case adjust this script by simply exporting the variables with the adjusted values

set -e -o pipefail

PONG_PORT="${PONG_PORT:-6666}"
SERVICE_PROTO="${SERVICE_PROTO:-t}"
SERVICE_PORT="${SERVICE_PORT:-25}"

# will exit is no socket is listening on the given port
while /bin/true ; do
    ss -ln"$SERVICE_PROTO" | grep ":${SERVICE_PORT}" > /dev/null
    nc -nvl -p "$PONG_PORT"

    sleep 1
done
