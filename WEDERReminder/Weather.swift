//
//  Weather.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/27/25.
//

import Foundation
import SwiftUI

struct Weather: View {
    @State private var city: String = ""
    @StateObject private var viewModel = WeatherViewModel()

    
    var body: some View {
            VStack(spacing: 20) {
                Text("Enter city to see weather.")

                TextField("City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        viewModel.fetchWeather(for: city)
                    }

                if let temp = viewModel.temperatureF {
                    Text("Temp: \(temp, specifier: "%.1f")°F")
                    Text(viewModel.isDay ? "Daytime" : "Nighttime")
                    Text(viewModel.isRaining ? "Raining" : "No rain")
                } else {
                    Text("Weather will show here.")
                }
            }
            .padding()
            .fontDesign(.monospaced)
        }
    

}
