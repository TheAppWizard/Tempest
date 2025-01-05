from flask import Flask, request, jsonify
import requests
from datetime import datetime

app = Flask(__name__)

# Helper function for weather forecast
def get_day_forecast(city, lat, lon, days):
    try:
        url = "https://api.open-meteo.com/v1/forecast"
        params = {
            "latitude": lat,
            "longitude": lon,
            "timezone": "auto",
            "daily": [
                "temperature_2m_max",
                "temperature_2m_min",
                "weather_code",
                "precipitation_probability_max",
                "wind_speed_10m_max",
                "sunrise",
                "sunset",
                "relative_humidity_2m_max"
            ],
            "forecast_days": days
        }
        
        response = requests.get(url, params=params)
        response.raise_for_status()
        data = response.json()
        
        weather_codes = {
            0: "Clear sky",
            1: "Mainly clear",
            2: "Partly cloudy",
            3: "Overcast",
            45: "Foggy",
            48: "Depositing rime fog",
            51: "Light drizzle",
            53: "Moderate drizzle",
            55: "Dense drizzle",
            61: "Slight rain",
            63: "Moderate rain",
            65: "Heavy rain",
            66: "Freezing Rain Light Intensity",
            67: "Freezing Rain Heavy Intensity",
            71: "Slight snow",
            73: "Moderate snow",
            75: "Heavy snow",
            77: "Snow grains",
            80: "Slight rain showers",
            81: "Moderate rain showers",
            82: "Violent rain showers",
            85: "Slight snow showers",
            86: "Heavy snow showers",
            95: "Thunderstorm",
            96: "Thunderstorm with slight hail",
            99: "Thunderstorm with heavy hail"
        }

        weather_quotes = {
            0: "It's f*cking beautiful out.",
            1: "It's f*cking nice today.",
            2: "There are f*cking clouds.",
            3: "It's f*cking gloomy.",
            45: "It's f*cking foggy.",
            48: "Watch out for this f*cking fog.",
            51: "It's f*cking drizzling.",
            53: "The drizzle is f*cking steady.",
            55: "This drizzle is f*cking heavy.",
            61: "It's f*cking sprinkling.",
            63: "It's f*cking raining now.",
            65: "It's f*cking pouring.",
            66: "The rain is f*cking freezing.",
            67: "This freezing rain is f*cking intense.",
            71: "It's f*cking snowing lightly.",
            73: "The snow is f*cking steady.",
            75: "It's f*cking dumping snow.",
            77: "These snow grains are f*cking weird.",
            80: "These f*cking rain showers.",
            81: "These showers are f*cking wild.",
            82: "This rain is f*cking violent.",
            85: "Light f*cking snow showers.",
            86: "Heavy f*cking snow showers.",
            95: "It's f*cking thundering.",
            96: "Thunder and f*cking hail.",
            99: "This storm is f*cking intense."
        }
        
        forecast = []
        daily = data["daily"]
        for i in range(days):
            date_obj = datetime.fromisoformat(daily["time"][i])
            date = date_obj.strftime('%Y-%m-%d')
            weather_desc = weather_codes.get(daily["weather_code"][i], "Unknown")
            weather_quote = weather_quotes.get(daily["weather_code"][i], "No f*cking clue.")
            
            
            forecast.append({
                "date": date,
                "day": date_obj.strftime('%A'),
                "max_temperature": daily['temperature_2m_max'][i],
                "min_temperature": daily['temperature_2m_min'][i],
                "conditions": weather_desc,
                "quotes":weather_quote,
                "weatherCode":daily["weather_code"][i],
                "precipitation_probability": daily['precipitation_probability_max'][i],
                "humidity": daily.get('relative_humidity_2m_max', [None])[i],
                "max_wind_speed": daily['wind_speed_10m_max'][i],
                "sunrise": daily['sunrise'][i],
                "sunset": daily['sunset'][i]
            })
        
        return {"city": city, "forecast": forecast}
    except requests.RequestException as e:
        return {"error": f"Error fetching weather data: {e}"}
    except KeyError as e:
        return {"error": f"Error parsing weather data: {e}"}
    except Exception as e:
        return {"error": f"An unexpected error occurred: {e}"}

# Flask route to handle API requests
@app.route('/weather', methods=['GET'])
def weather_api():
    city = request.args.get('city', 'Unknown')
    lat = request.args.get('lat', type=float)
    lon = request.args.get('lon', type=float)
    days = request.args.get('days', default=7, type=int)

    if not lat or not lon:
        return jsonify({"error": "Latitude and longitude are required"}), 400

    result = get_day_forecast(city, lat, lon, days)
    return jsonify(result)


# Route to get place details
@app.route('/geocoding', methods=['GET'])
def get_place_details():
    query = request.args.get('place')
    
    if not query:
        return jsonify({"error": "Place query is required"}), 400
    
    try:
        # Make request to OpenStreetMap API
        url = "https://nominatim.openstreetmap.org/search"
        headers = {
            "User-Agent": "tempest/1.0"
        }
        params = {
            "q": query,
            "format": "json"
        }
        response = requests.get(url, params=params, headers=headers)
        response.raise_for_status()
        data = response.json()
        
        if not data:
            return jsonify({"error": f"No results found for place: {query}"}), 404
        
        # Extract custom fields from the response
        result = []
        for place in data:
            result.append({
                "place_id": place.get("place_id"),
                "lat": place.get("lat"),
                "lon": place.get("lon"),
                "name": place.get("name"),
                "display_name": place.get("display_name"),
                "addresstype": place.get("addresstype")
            })
        
        return jsonify(result)
    
    except requests.RequestException as e:
        return jsonify({"error": f"Error fetching place details: {e}"}), 500
    except Exception as e:
        return jsonify({"error": f"An unexpected error occurred: {e}"}), 500    

if __name__ == '__main__':
    app.run(debug=True)
