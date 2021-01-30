# temperature_sensor_json

# Description

This will read a DHT11 temperature and humidity sensor
from the GPIO on a Raspberry Pi and return the results
in a nicely formatted JSON object.

# Installation

Copy, clone, or symlink this directory to
`/usr/local/temperature_sensor_json`

To have the sensor start at boot and return the results
via HTTP request (using Flask), copy or symlink the
`temperature_sensor.service` file to `/etc/systemd/system/`

Note: when updating systemd services, be sure to reload
them after every change:

```
systemctl daemon-reload
```

# Usage

To perform a one-time read of the sensor and display the
JSON output, run the `dht11.py` program:

```shell
python3 ./dht11.py
```

To run the sensor as a RESTful API that reads the sensor
upon request, use Flask:

```shell
flask run
```
