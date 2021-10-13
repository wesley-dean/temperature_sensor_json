#!/bin/sh

## @file temperature_sensor_server.sh
## @brief start temperature server and restart it should it fail
## @details
## Originally, this project was running on a Raspberry Pi running
## Raspbian which is a derivative of Debian.  Debian runs systemd.
## So, there originally was a .service file that would do all the
## things.  When I moved to a system that didn't use systemd
## (e.g., Alpine which uses OpenRC), a systemd .service file was
## useless.  So, rather than write files for systemd and OpenRC
## and whatever other else, I just put together a script that
## does the same thing.  This is that script.
##
## Essentially, this script runs flask (a Python framework) to
## provide a RESTful API that can be queried via HTTP requests.
## The script loops forever such that if flask should croak
## for whatever reason, it'll wait a few seconds then attempt
## to restart it.  If the script (not flask -- the script)
## receives a signal to stop, then stop the script; otherwise,
## if flask receives the signal, it'll end, the script will
## loop, and flask will be restarted.
##
## Finally, if another program is listening on the port (the
## $PORT environment variable which is 5001/TCP by default),
## then croak with a non-zero result code (i.e., don't try
## to restart).
## @author Wesley Dean (wesley-dean)

## @var PORT
## @brief the TCP port upon which to listen for requests (def: 5001)
##
## @var SERVER_HOME
## @brief filesystem location where the program should run
##
## @var DHT_PIN
## @brief the GPIO pin connected to the sensor's signal (def: 4)
##
## @var SLEEP_TIME
## @brief how many seconds to sleep between flask restarts (def: 10)

PORT="${PORT:-5001}"
SERVER_HOME="${SERVER_HOME:-$(realpath "$(dirname "$0")")}"
DHT_PIN="${DHT_PIN:-4}"
SLEEP_TIME="${SLEEP_TIME:-10}"

cd "${SERVER_HOME}" || exit 1

# if we're told to quit (e.g., we receive SIGINT or control-c), quit
trap exit INT QUIT TERM

# loop forever
while true; do
  netstat -tln  | grep -qEe "\b$PORT\b" && echo "A process is already listening on port $PORT" && exit 1

  # if flask croaks, give it some time and then restart it
  flask run || sleep "$SLEEP_TIME"

done

exit 0
