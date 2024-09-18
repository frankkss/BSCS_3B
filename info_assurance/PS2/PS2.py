# Visit https://www.lddgo.net/en/string/pyc-compile-decompile for more information
# Version : Python 3.9

import random
import time

class TemperatureSensor:
    
    def __init__(self, name, location):
        self.name = name
        self.location = location

    
    def read_temperature(self):
        return round(random.uniform(20, 30), 1)



class SmartThermostat:
    
    def __init__(self, name):
        self.name = name
        self.target_temperature = 22
        self.current_temperature = 22
        self.is_heating = False

    
    def set_target_temperature(self, temperature):
        self.target_temperature = temperature

    
    def update_current_temperature(self, temperature):
        self.current_temperature = temperature
        if self.current_temperature < self.target_temperature:
            self.is_heating = True
        else:
            self.is_heating = False

    
    def status(self):
        return f'''Current: {self.current_temperature}°C, Target: {self.target_temperature}°C, Heating: {'On' if self.is_heating else 'Off'}'''



def simulate_smart_home():
    living_room_sensor = TemperatureSensor('Living Room Sensor', 'Living Room')
    bedroom_sensor = TemperatureSensor('Bedroom Sensor', 'Bedroom')
    thermostat = SmartThermostat('Main Thermostat')
    for _ in range(10):
        living_room_temp = living_room_sensor.read_temperature()
        bedroom_temp = bedroom_sensor.read_temperature()
        average_temp = (living_room_temp + bedroom_temp) / 2
        thermostat.update_current_temperature(average_temp)
        print(f'''Time: {time.strftime('%H:%M:%S')}''')
        print(f'''Living Room: {living_room_temp}°C''')
        print(f'''Bedroom: {bedroom_temp}°C''')
        print(f'''Thermostat: {thermostat.status()}''')
        print('----------------------------------------')
        time.sleep(2)

if __name__ == '__main__':
    simulate_smart_home()