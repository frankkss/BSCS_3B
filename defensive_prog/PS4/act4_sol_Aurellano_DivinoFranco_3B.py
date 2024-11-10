"""
 Areas where the original code can be improve or refactor:
 1. The code can be improved by adding a command-line interface for the process_weather_data function.
 2. The code can be improved by adding error handling for file not found and csv file errors.
 3. The code can be improved by adding a function to read the csv file and return the data as a list of dictionaries.
 4. The code can be improved by adding a function to compute the average temperature, average humidity, day with highest humidity, maximum temperature, and minimum temperature.
 5. The code can be improved by adding a function to print the computed statistics.
 6. The code can be improved by adding type hints and docstrings to improve readability and maintainability.

Refactored Code:
- The refactored code added new functions.
        - The read_weather_data function reads the csv file and returns the data as a list of dictionaries.
        - The calculate_statistics function computes the average temperature, average humidity, day with highest humidity, maximum temperature, minimum temperature, and median temperature.
        - The print_statistics function prints the computed statistics.
        - The process_weather_data function calls the read_weather_data, calculate_statistics, and print_statistics functions.
- It includes error handling for file not found and csv file errors.
- It has a command-line interface for the process_weather_data function.
- The refactored code uses the statistics module to calculate the median temperature.

The refactored code is more readable, reusable, and has better error handling. The user would be able to know what went wrong if there is an error in the code because of the 
easy to read error messages.
"""

#Refactored code
import csv
from typing import List, Dict, Tuple, Optional
import statistics

def read_weather_data(file_path: str) -> List[Dict[str, str]]:
    try:
        with open(file_path, 'r') as f:
            reader = csv.DictReader(f)
            return [row for row in reader if 'temperature' in row and 'humidity' in row]
    except FileNotFoundError:
        print(f"Error: File not found - {file_path}")
    except Exception as e:
        print(f"Error: {e}")
    return []

def calculate_statistics(data: List[Dict[str, str]]) -> Optional[Tuple[float, float, float, float, float, str]]:
    if not data:
        return None

    temperatures = []
    humidities = []
    highest_humidity_day = ""
    highest_humidity = float('-inf')

    for item in data:
        try:
            temp = float(item['temperature'])
            humidity = float(item['humidity'])
        except ValueError:
            print("Warning: Invalid data format.")
            continue

        temperatures.append(temp)
        humidities.append(humidity)

        if humidity > highest_humidity:
            highest_humidity = humidity
            highest_humidity_day = item.get('date', 'Unknown')

    avg_temp = statistics.mean(temperatures)
    avg_humidity = statistics.mean(humidities)
    max_temp = max(temperatures)
    min_temp = min(temperatures)
    median_temp = statistics.median(temperatures)

    return avg_temp, avg_humidity, max_temp, min_temp, median_temp, highest_humidity_day

def print_statistics(stats: Tuple[float, float, float, float, float, str]) -> None:
    avg_temp, avg_humidity, max_temp, min_temp, median_temp, highest_humidity_day = stats
    print(f"Average Temperature: {avg_temp:.2f}°C")
    print(f"Average Humidity: {avg_humidity:.2f}%")
    print(f"Maximum Temperature: {max_temp:.2f}°C")
    print(f"Minimum Temperature: {min_temp:.2f}°C")
    print(f"Median Temperature: {median_temp:.2f}°C")
    print(f"Day with Highest Humidity: {highest_humidity_day}")

def process_weather_data(file_path: str) -> None:
    data = read_weather_data(file_path)
    stats = calculate_statistics(data)
    if stats:
        print_statistics(stats)

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Process weather data.")
    parser.add_argument("file_path", type=str, help="Path to the weather data CSV file.")
    args = parser.parse_args()

    process_weather_data(args.file_path)
