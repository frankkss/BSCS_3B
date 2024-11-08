import csv 
# Original code to refactor
def process_weather_data(file_path: str) -> None: 
    data = [] 
    with open(file_path, 'r') as f: 
        reader = csv.DictReader(f) 
        for row in reader: 
            data.append(row) 
            
    total_temp = 0 
    total_humidity = 0 
    max_temp = float('-inf') 
    min_temp = float('inf') 
    for item in data: 
        temp = float(item['temperature']) 
        humidity = float(item['humidity']) 
        total_temp += temp 
        total_humidity += humidity 
        if temp > max_temp: 
                    max_temp = temp 
        if temp < min_temp:
            min_temp = temp 

    avg_temp = total_temp / len(data) 
    avg_humidity = total_humidity / len(data) 

    print(f"Average Temperature: {avg_temp:.2f}°C") 
    print(f"Average Humidity: {avg_humidity:.2f}%") 
    print(f"Maximum Temperature: {max_temp:.2f}°C") 
    print(f"Minimum Temperature: {min_temp:.2f}°C") 

# Example usage 
process_weather_data('weather_data.csv')