#!/bin/bash
#
# @author Emiliano Gabrielli <albert@faktiva.com>
# @license MIT
#
# This script is intended to monitor the availability of a given service on the provided port.
# It listens for connections on its own port (6666), while monitoring a given socket to the provided service port (25).
# If the monitored service become unresponsive the script exits, thus making the endpoint it provides unreachable.
#
# The tipical use case is to act as an heath check endpoint for a SMTP cluster behind a Load Balancer, 
# it has been used this way for long time in production environment on AWS.
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

# will exit if no socket is listening on the given port
while /bin/true ; do
    ss -ln"${SERVICE_PROTO}" | grep ":${SERVICE_PORT}" > /dev/null
    sleep 1
done
