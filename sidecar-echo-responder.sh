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

# create a pipe to have the client's input back to it
PIPE_FILE="$(mktemp -u -t sidecar-echo-responder.XXX.fifo)"
[ -p "${PIPE_FILE}" ] || mknod -m 777 "${PIPE_FILE}" p

# start netcat in listening and keepalive mode
printf "Starting echo responder on port '%s'\n" "${PONG_PORT}"
cat "${PIPE_FILE}" | nc -lk -p "${PONG_PORT}" > "${PIPE_FILE}" &

# will exit is no socket is listening on the given port
while /bin/true ; do
    ss -ln"${SERVICE_PROTO}" | grep ":${SERVICE_PORT}" > /dev/null
    sleep 1
done
