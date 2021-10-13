# temperature_sensor_json

# Description

This will read a DHT11 temperature and humidity sensor
from the GPIO on a Raspberry Pi and return the results
in a nicely formatted JSON object.

# Installation

## Prequesites

There is a `requirements.txt` file which includes the needed
packages and such so one may use `pip install -r requirements.txt`
to install them.  However, for reasons beyond my patience to
explore, this can flake out on my Raspberry Pis and I find
using the system package manager works better:

```shell
sudo apt-get install python3-dotenv python3-flask
```

## Hardware Setup (GPIO)

I used a DHT11 temeprature and humidity sensor with three pins
that is mounted to a PCB with a 10K Ohm pull-up resistor.  The
sensors are very inexpensive (I paid $10 for 5 of them on
Amazon) but they're also less accurate than, for example a
DHT22 sensor.  Compared to a DHT22, a DHT11 has less accurate 
and smaller ranges for temperature and humidity but costs
half as much.  Since I'm primarily using the sensors in
use cases such as determining when to run a dehumidifier,
a DHT11 is perfectly acceptable to me.

I use the following pins on my devices:

```
 1: . .
 3: . +
 5: . -
 7: s .
 9: . .
11: . .
13: . .
15: . .
17: . .
19: . .
21: . .
23: . .
25: . .
```

or:

* pin 4: power (5v)
* pin 6: ground
* pin 7: signal

I didn't bother with a breadboard -- I used the 3x female
to female wires that came with the DHT11 sensor.

## Server Startup

Copy, clone, or symlink this directory to
`/usr/local/temperature_sensor_json`

To have the sensor start at boot and return the results
via HTTP request (using Flask), run the provided 
`temperature_sensor_server.sh` script.

It may be preferable to have the service start at boot and
restart should it croak.  If that's desired, either add a
line to run the provided script to a boot script or crontab.


# Usage

## Command Line Interface

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

### Environment Variables

* `DHT_PIN`: which pin is used carry the signal from the sensor (4)
* `SERVER_HOME`: where on the device the software was installed (.)
* `PORT`: which port Flask should listen on (5001)

## RESTful API

The Flask service listens on port 5001 for incoming HTTP
(not HTTPS!) connections; it responds with a JSON object
that looks like this:

```json
{
  "celcius": "22.0",
  "fahrenheit": "71.6",
  "humidity": "68.0",
  "localtime": "Sat Oct 09 14:09:03 2021",
  "gm": "Sat Oct 09 18:09:03 2021"
}
```
