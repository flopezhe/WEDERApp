//
//  WeatherView.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/27/25.
//

import Foundation
import SwiftUI

struct City: Codable, Identifiable {
    let id: UUID = UUID()
    let name: String
}

class CityStore: ObservableObject {
    @Published var cities: [City] = []

    init() {
        loadCities()
    }

    func addCity(_ city: City) {
        cities.append(city)
        saveCities()
    }
    
    func deleteCity(id: UUID) {
        if let index = self.cities.firstIndex(where: { $0.id == id }) {
            self.cities.remove(at: index)
        }
        saveCities()
    }

    private func saveCities() {
        if let data = try? JSONEncoder().encode(cities) {
            UserDefaults.standard.set(data, forKey: "savedCities")
        }
    }

    private func loadCities() {
        if let data = UserDefaults.standard.data(forKey: "savedCities"),
           let decoded = try? JSONDecoder().decode([City].self, from: data) {
            cities = decoded
        }
    }
}


struct WeatherView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject var cityStore = CityStore()
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = ""
    @State private var isInvalidCity: Bool = false
    
    var body: some View {
            VStack(spacing: 20) {
                Text("Enter city to see weather.")

                HStack {
                    TextField("City", text: $city)
                        .overlay(RoundedRectangle(cornerRadius: 1)
                            .stroke(isInvalidCity ? .red : isDarkMode ? Color.white : Color.black, lineWidth: 1))
                        .onSubmit {
                            let invalidSet = CharacterSet.symbols
                                .union(.punctuationCharacters)
                                .union(.decimalDigits)
                            
                            if city.isEmpty || city.rangeOfCharacter(from: invalidSet) != nil {
                                isInvalidCity = true
                            }
                            else {
                                isInvalidCity = false
                                viewModel.fetchWeather(for: city)
                            }
                        }
                    Button(action: {
                        let invalidSet = CharacterSet.symbols
                            .union(.punctuationCharacters)
                            .union(.decimalDigits)
                        
                        if city.isEmpty || city.rangeOfCharacter(from: invalidSet) != nil {
                            isInvalidCity = true
                        }
                        else {
                            isInvalidCity = false
                            viewModel.fetchWeather(for: city)
                        }
                    }, label: {
                        Text("Enter")
                            .fontDesign(.monospaced)
                            .padding()
                            .background(isDarkMode ? Color.white : Color.black)
                            .foregroundColor(isDarkMode ? .black : .white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .fixedSize()
                    })
                }
                
                if isInvalidCity {
                    Text("Please Enter Valid City")
                        .foregroundStyle(.red)
                }

                if let temp = viewModel.temperatureF {
                    Text("Temp: \(temp, specifier: "%.1f")°F")
                    Text(viewModel.isDay ? "Daytime" : "Nighttime")
                    Text(viewModel.isRaining ? "Raining" : "No rain")
                }
                else {
                    Text("Weather will show here.")
                }
                
                Button(action: {
                    let cityToSave = City(name: city)
                    cityStore.addCity(cityToSave)
                }, label: {
                    Text("Save City")
                        .fontDesign(.monospaced)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isDarkMode ? Color.white : Color.black)
                        .foregroundColor(isDarkMode ? .black : .white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                })
                
                NavigationLink(destination: SavedCitiesView(cityStore: cityStore)) {
                    Text("See Saved Cities")
                        .fontDesign(.monospaced)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isDarkMode ? Color.white : Color.black)
                        .foregroundColor(isDarkMode ? .black : .white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding()
            .fontDesign(.monospaced)
        }
}
