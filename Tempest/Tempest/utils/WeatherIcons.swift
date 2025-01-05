//
//  WeatherIcons.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import SwiftUI

struct WeatherIcons {
    static let icons: [Int: String] = [
        0: "sun.max",                   // Clear sky
        1: "cloud.sun",                 // Mainly clear
        2: "cloud",                     // Partly cloudy
        3: "cloud",                     // Overcast
        45: "cloud.fog",                // Foggy
        48: "cloud.fog",                // Depositing rime fog
        51: "cloud.drizzle",            // Light drizzle
        53: "cloud.drizzle",            // Moderate drizzle
        55: "cloud.drizzle",            // Dense drizzle
        61: "cloud.rain",               // Slight rain
        63: "cloud.rain",               // Moderate rain
        65: "cloud.heavyrain",          // Heavy rain
        66: "cloud.sleet",              // Freezing Rain Light Intensity
        67: "cloud.sleet",              // Freezing Rain Heavy Intensity
        71: "cloud.snow",               // Slight snow
        73: "cloud.snow",               // Moderate snow
        75: "cloud.snow",               // Heavy snow
        77: "snowflake",                // Snow grains
        80: "cloud.rain",               // Slight rain showers
        81: "cloud.rain",               // Moderate rain showers
        82: "cloud.heavyrain",          // Violent rain showers
        85: "cloud.snow",               // Slight snow showers
        86: "cloud.snow",               // Heavy snow showers
        95: "cloud.bolt",               // Thunderstorm
        96: "cloud.bolt.rain",          // Thunderstorm with slight hail
        99: "cloud.bolt.rain"           // Thunderstorm with heavy hail
    ]
    
    static func iconName(for id: Int) -> String {
        return icons[id] ?? "questionmark.circle"
    }
}
