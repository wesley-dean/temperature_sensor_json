#!/usr/bin/env python3
""" read a DHT11 temperature / humidity sensor and spit it out as JSON """

import json
import time
import Adafruit_DHT

DHT_SENSOR = Adafruit_DHT.DHT11
DHT_PIN = 4


def main():
    """ the main function """

    result = {}

    humidity, temperature = Adafruit_DHT.read(DHT_SENSOR, DHT_PIN)

    if humidity is not None and temperature is not None:

        result["celcius"] = "{0:.1f}".format(temperature)
        result["fahrenheit"] = "{0:.1f}".format(32 + (9 / 5 * temperature))
        result["humidity"] = "{0:.1f}".format(humidity)
        result["localtime"] = time.asctime(time.localtime())
        result["gm"] = time.asctime(time.gmtime())

        print(json.dumps(result))


if __name__ == "__main__":
    main()
