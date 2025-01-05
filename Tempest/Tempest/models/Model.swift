//
//  Model.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import Foundation

struct Location: Codable {
    let addresstype: String
    let display_name: String
    let lat: String
    let lon: String
    let name: String
    let place_id: Int
}

struct WeatherResponse: Codable {
    let city: String
    let forecast: [Forecast]
}

struct Forecast: Codable, Identifiable {
    let conditions: String
    let date: String
    let day: String
    let humidity: Int
    let max_temperature: Double
    let max_wind_speed: Double
    let min_temperature: Double
    let precipitation_probability: Int
    let quotes: String
    let sunrise: String
    let sunset: String
    let weatherCode: Int
    
    var id: String { date }
}
