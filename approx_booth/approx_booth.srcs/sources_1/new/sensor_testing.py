import spidev
import time
from firebase import firebase
import RPi.GPIO as GPIO
import pyrebase
from time import sleep
config = {
 "apiKey": "database-secret",
 "authDomain": "project-id.firebaseapp.com",
 "databaseURL": "https://database-url.firebaseio.com",
 "storageBucket": "project-id.appspot.com"
}
 
firebase = pyrebase.initialize_app(config)
db = firebase.database()

#Define Variables
delay = 0.5
pressure_channel = 0
temp_channel=1
strain_channel=2
#constants
beta=2.2*(10^-3)      #semiconductor value
temp=25               #standard temperature in centigrade
ro=200                #ideal condition resistance
#epsilon=             #to find strain
gf=5                  #gauge factor

#spi setup
spi = spidev.SpiDev()
spi.open(0, 0)
spi.max_speed_hz=1000000

def readadc(adcnum):
    # read SPI data from the MCP3008, 8 channels in total
    if adcnum > 7 or adcnum < 0:
        return -1
    r = spi.xfer2([1, 8 + adcnum << 4, 0])
    data = ((r[1] & 3) >> 8) + r[2]
    return data
def mode1(pressure_value)
    pad_value1 = readadc(pressure_channel)
    print("---------------------------------------")
    print("Resistance Value as pressure is applied in kiloohm: %d" % pad_value)

def mode2(temperature_value)
    pad_value2 = readadc(temp_channel)
    newtemp=((1-(pad_value/ro)/beta))+temp
    print("---------------------------------------")
    print("Resistance Value as temperature is applied in kiloohm: %d" % pad_value)
    
def mode3(strain_value)
    pad_value3 = readadc(strain_channel)
    dr=abs(ro-pad_value)
    epsilon=dr/gf
    print("---------------------------------------")
    print("Resistance Value as strain is applied is applied in kiloohm: %d" % pad_value)
    
try:
    while True:

        db = firebase.database()
        sensor = db.child("Sensors")
        reading = sensor.child("Readings").get().val()
        if "true" in readings.lower():
            database = firebase.database()
            sensor = database.child("Sensor1")
            pressure = sensor.child("Pressure").get().val()

            database = firebase.database()
            sensor = database.child("Sensor2")
            strain = sensor.child("Strain").get().val()

            database = firebase.database()
            sensor = database.child("Sensor3")
            temperature = sensor.child("Temperature").get().val()

            database = firebase.database()
            sensor = database.child("Option")
            optioninput = sensor.child("optioninput").get().val()
            
            if "mode1" in optioninput.lower():
                mode1(int(pressure))
            elif "mode2" in optioninput.lower():
                mode1(int(temperature))
            elif "mode3" in optioninput.lower():
                mode3(int(strain)) 
        else:
            print("DAMN, the readings is: " + powerState)        

except KeyboardInterrupt:
    GPIO.cleanup()            