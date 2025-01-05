//
//  NetworkManager.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    func searchLocation(query: String) -> AnyPublisher<[Location], Error> {
        let urlString = "http://yoururl/tempest/geocoding?place=\(query)"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Location].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getWeather(city: String, lat: String, lon: String) -> AnyPublisher<WeatherResponse, Error> {
        let urlString = "http://yoururl/tempest/weather?city=\(city)&lat=\(lat)&lon=\(lon)&days=16"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
