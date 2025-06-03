//
//  SavedCitiesView.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/28/25.
//

import SwiftUI

struct SavedCitiesView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @ObservedObject var cityStore: CityStore
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityBeingViewed: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome to Your Saved Cities!")
            
            if cityStore.cities.isEmpty {
                Text("You do not currently have any cities saved.")
            }
            else {
                ForEach(cityStore.cities, id: \.name) {city in
                    Button(action: {
                        cityBeingViewed = city.name
                        viewModel.fetchWeather(for: city.name)
                    }, label: {
                        Text(city.name)
                            .fontDesign(.monospaced)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isDarkMode ? Color.white : Color.black)
                            .foregroundColor(isDarkMode ? .black : .white)
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        cityStore.deleteCity(id: city.id)
                    }, label: {
                        Text("Delete City")
                            .fontDesign(.monospaced)
                            .padding()
                            .fixedSize(horizontal: true , vertical: false )
                            .background(isDarkMode ? Color.white : Color.black)
                            .foregroundColor(isDarkMode ? .black : .white)
                            .cornerRadius(10)
                    })
                    
                }
                
                if let temp = viewModel.temperatureF {
                    Text("Temp: \(temp, specifier: "%.1f")°F")
                    Text(viewModel.isDay ? "Daytime" : "Nighttime")
                    Text(viewModel.isRaining ? "Raining" : "No rain")
                }
                else {
                    Text("You can only view one city at a time. ")
                    Text("Weather will show here.")
                }
            }
        }
        .fontDesign(.monospaced)
    }
    
    
}

