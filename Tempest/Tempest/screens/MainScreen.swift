//
//  MainScreen.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import SwiftUI

struct MainScreen: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var selectedForecast: Forecast?
    @State private var isSearchExpanded = false
    
    var body: some View {
        ZStack {
           
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "1f4068"),
                    Color(hex: "162447"),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        
        
            
            // Animated background particles
            GeometryReader { geometry in
                ForEach(0..<20) { _ in
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: CGFloat.random(in: 2...6))
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                        .animation(
                            Animation.linear(duration: Double.random(in: 5...10))
                                .repeatForever(autoreverses: true),
                            value: UUID()
                        )
                }
            }
            
            VStack(spacing: 20) {
                // Animated search bar
                searchBar
                    .offset(y: isSearchExpanded ? 0 : -10)
                
                if let weatherData = viewModel.weatherData,
                   let selectedForecast = selectedForecast ?? weatherData.forecast.first {
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 25) {
                            // Location and current weather
                          
                            ZStack{
                                Rectangle()
                                    .frame(height: 10)
                                    .foregroundStyle(.black)
                                    .offset(y:170)
                                
                                LottieView(animationName: "clouds", loopMode: .loop)
                                    .offset(x:0,y:-150)
                                    .opacity(0.1)
                                    .blur(radius: 5)
                                
                                LottieView(animationName: "windmill", loopMode: .loop)
                                    .offset(x:100,y:65)
                                
                                Image("home")
                                    .resizable()
                                    .frame(width: 50,height: 50)
                                    .offset(x:0,y:145)
                                
                                
                                HStack{
                                    VStack(alignment:.leading,spacing: 0) {
                                            Text(weatherData.city)
                                                .font(.system(size: 32, weight: .regular))
                                                .foregroundColor(.white)
                                                .shadow(radius: 2)
                                           
                                        Text(selectedForecast.conditions)
                                                .font(.title3)
                                                .foregroundColor(.white.opacity(0.2))
                                                .shadow(radius: 2)
                                            
                                            HStack{
                                                WeatherIconView(
                                                    weatherID: selectedForecast.weatherCode,
                                                    iconColor: .white,
                                                    frameWidth: 55,
                                                    frameHeight: 55
                                                )
                                                .shadow(radius: 5)
                                                
                                                Text("\(Int(selectedForecast.max_temperature))°")
                                                    .font(.system(size: 72, weight: .regular))
                                                    .foregroundColor(.white)
                                                    .shadow(radius: 2)
                                            }
                                        
                                        
                                          Spacer()
                                        }
                                    
                                    Spacer()
                                }.padding(20)
                                

                            }
                            .frame(height: 300)
                            .padding(.vertical, 30)
                            
                            // Weather details card
                            weatherDetailsCard(for: selectedForecast)
                                .transition(.scale)
                            
                            // Forecast cards
                            VStack(alignment: .leading) {
                                Text("Forecast")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(weatherData.forecast) { day in
                                            CardForecast(
                                                forecast: day,
                                                isSelected: day.id == selectedForecast.id
                                            ) {
                                                withAnimation(.spring()) {
                                                    self.selectedForecast = day
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                    }
                }
            }
        }
        .onAppear {
            withAnimation {
                isSearchExpanded = true
            }
            if let firstForecast = viewModel.weatherData?.forecast.first {
                selectedForecast = firstForecast
            }
        }
    }
    
    private var searchBar: some View {
        HStack {
            HStack {
                     Image(systemName: "magnifyingglass")
                         .foregroundColor(.white.opacity(0.7))
                     
                     ZStack(alignment: .leading) {
                         if viewModel.searchText.isEmpty {
                             Text("Search location")
                                 .foregroundColor(.white.opacity(0.7))
                         }
                         
                         TextField("", text: $viewModel.searchText)
                             .foregroundColor(.white)
                             .autocapitalization(.none)
                             .disableAutocorrection(true)
                     }
                 }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            
            Button(action: {
                withAnimation {
                    viewModel.searchAndFetchWeather()
                }
            }) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
    }
    
    private func weatherDetailsCard(for forecast: Forecast) -> some View {
        VStack(spacing: 20) {
            HStack(spacing: 30) {
                weatherDetailItem(
                    icon: "thermometer",
                    title: "Min Temp",
                    value: "\(Int(forecast.min_temperature))°"
                )
                
                weatherDetailItem(
                    icon: "thermometer.sun",
                    title: "Max Temp",
                    value: "\(Int(forecast.max_temperature))°"
                )
                
                weatherDetailItem(
                    icon: "wind",
                    title: "Wind Speed",
                    value: "\(Int(forecast.max_wind_speed))km/h"
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
        .padding(.horizontal)
    }
    
    private func weatherDetailItem(icon: String, title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}

struct CardForecast: View {
    let forecast: Forecast
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text(forecast.day.prefix(3))
                .font(.headline)
                .foregroundColor(.white)
            
            WeatherIconView(
                weatherID: forecast.weatherCode,
                iconColor: .white,
                frameWidth: 40,
                frameHeight: 40
            )
            
            Text("\(Int(forecast.max_temperature))°")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("\(Int(forecast.min_temperature))°")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    isSelected ? Color.white : Color.clear,
                    lineWidth: 1
                )
        )
        .onTapGesture(perform: onTap)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    MainScreen()
}
