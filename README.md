# sidecar-echo-responder

Simple shell script to add "**pong**" feature to services not having it, such as _**SMTP**_

___

## Requirements:

- netcat (**`nc`**)
- socket statistics (**`ss`**)

Both should be already be installed on the majority of Linux distributions.

## How it works

- it spans a **`nc`** process, in *listening* and *keep-alive* mode, on a configurable port (defaults `6666`)
- it loops forever and checks for a live socket on the given port/protocol
- you (your Load Balancer) can ping it to check the monitored service health
- since the main loop is executed with `set -e -o pipefail` bash options it will exit if the socket is not found
- your LB will receive no more pongs :)

## Execution

```
nohup sidecar-echo-responder.sh > /dev/null &
```

Enjoy
