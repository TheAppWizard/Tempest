//
//  WeatherIconView.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import SwiftUI

struct WeatherIconView: View {
    let weatherID: Int
    let iconColor : Color
    let frameWidth : Double
    let frameHeight: Double

    var body: some View {
        Image(systemName: WeatherIcons.iconName(for: weatherID))
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth, height: frameHeight)
            .foregroundStyle(iconColor)
    }
}

#Preview {
    WeatherIconView(
        weatherID: 45,
        iconColor: .black,
        frameWidth: 100,
        frameHeight: 100
    )
}



