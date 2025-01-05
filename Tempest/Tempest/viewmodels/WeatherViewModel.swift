//
//  WeatherViewModel.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var weatherData: WeatherResponse?
    @Published var isLoading = false
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func searchAndFetchWeather() {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        error = nil
        
        NetworkManager.shared.searchLocation(query: searchText)
            .compactMap { $0.first } // Take first location as requested
            .flatMap { location -> AnyPublisher<WeatherResponse, Error> in
                NetworkManager.shared.getWeather(
                    city: location.name,
                    lat: location.lat,
                    lon: location.lon
                )
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] response in
                    self?.weatherData = response
                }
            )
            .store(in: &cancellables)
    }
}
