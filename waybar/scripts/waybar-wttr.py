#!/usr/bin/env python3
import json
import requests
from datetime import datetime

# Hava durumu durum kodlarına göre ikonlar (İstediğin gibi değiştirebilirsin)
WEATHER_CODES = {
    '113': '☀️', '116': '⛅', '119': '☁️', '122': '☁️',
    '143': '🌫️', '176': '🌦️', '179': '🌧️', '182': '🌧️',
    '185': '🌧️', '200': '⛈️', '227': '❄️', '230': '❄️',
    '248': '🌫️', '260': '🌫️', '263': '🌧️', '266': '🌧️',
    '293': '🌧️', '296': '🌧️', '299': '🌧️', '302': '🌧️',
    '305': '🌧️', '308': '🌧️', '311': '🌧️', '314': '🌧️',
    '317': '🌧️', '320': '❄️', '323': '❄️', '326': '❄️',
    '329': '❄️', '332': '❄️', '335': '❄️', '338': '❄️',
    '350': '🌧️', '353': '🌧️', '356': '🌧️', '359': '🌧️',
    '362': '🌧️', '365': '🌧️', '368': '❄️', '371': '❄️',
    '374': '🌧️', '377': '🌧️', '386': '⛈️', '389': '⛈️',
    '392': '❄️', '395': '❄️'
}

LOCATION = "Trabzon"
# LOCATION = "Ankara+Söğütözü"

data = {}
try:
    # Konumunu otomatik bulması için boş bırakabilir veya "Ankara", "Istanbul" yazabilirsin
    req = requests.get(f"https://wttr.in/{LOCATION}?format=j1")
    res = req.json()
    current = res['current_condition'][0]
    
    temp = current['temp_C']
    code = current['weatherCode']
    icon = WEATHER_CODES.get(code, '🌡️')
    
    # Waybar'ın beklediği JSON formatı
    data['text'] = f"{icon} {temp}°C"
    data['tooltip'] = f"Feels Like: {current['FeelsLikeC']}°C\nHumidity: {current['humidity']}%\nWind: {current['windspeedKmph']} km/h"
except Exception:
    data['text'] = " N/A"
    data['tooltip'] = "Connection Error"

print(json.dumps(data))
