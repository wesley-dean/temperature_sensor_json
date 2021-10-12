#!/bin/sh

PORT="${PORT:-5001}"
SERVER_HOME="${SERVER_HOME:-.}"
DHT_PIN="${DHT_PIN:-4}"

cd "${SERVER_HOME}" || exit 1

netstat -tln  | grep -qEe "\b$PORT\b" && echo "A process is already listening on port $PORT" && exit 1

flask run

$0
