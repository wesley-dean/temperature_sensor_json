#!/usr/bin/env python3

""" read a DHT11 temperature / humidity sensor and spit it out as JSON """

import json
import time
from flask import Flask
import Adafruit_DHT

DHT_SENSOR = Adafruit_DHT.DHT11
DHT_PIN = 4


app = Flask(__name__)


@app.route("/")
def read_sensor(pin=4, sensor=None):

    if sensor is None:
        sensor = Adafruit_DHT.DHT11

    result = {}

    humidity, temperature = Adafruit_DHT.read(sensor, pin)

    if humidity is not None and temperature is not None:

        result["celcius"] = "{0:.1f}".format(temperature)
        result["fahrenheit"] = "{0:.1f}".format(32 + (9 / 5 * temperature))
        result["humidity"] = "{0:.1f}".format(humidity)
        result["localtime"] = time.asctime(time.localtime())
        result["gm"] = time.asctime(time.gmtime())

    return json.dumps(result)


def main():
    """ the main function """

    print(read_sensor(DHT_PIN, DHT_SENSOR))


if __name__ == "__main__":
    main()
