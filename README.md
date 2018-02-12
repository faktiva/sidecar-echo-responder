# sidecar-echo-responder

Simple shell script to add "**pong**" feature to services such as _SMTP_

___

## Requirements:

- netcat (**`nc`**) with `-e` feature enabled (`netcat-traditional` package on Ubuntu)

## How it works

- it spans a **`nc`** process, in listening mode, on a configurable port (defaults `6666`)
- your Load Balancer will ping it to check the monitored service health
- on each LB connection it spans a `service-ping.sh` by means of the `-e` feature of netcat
- since the main loop is executed with `set -e -o pipefail` bash options it will exit whenever the ping fail
- your LB will receive no more pongs :)
