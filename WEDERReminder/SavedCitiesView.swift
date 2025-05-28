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
    
    var body: some View {
        VStack {
            Text("Welcome to Your Saved Cities!")
            
            if cityStore.cities.isEmpty {
                Text("You do not currently have any cities saved.")
            }
            else {
                ForEach(cityStore.cities, id: \.name) {city in
                    Text(city.name)
                    
                    Button(action: {
                        cityStore.deleteCity(id: city.id)
                    }, label: {
                        Text("Delete City")
                            .fontDesign(.monospaced)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isDarkMode ? Color.white : Color.black)
                            .foregroundColor(isDarkMode ? .black : .white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                    
                    Spacer()
                }
            }
        }
        .fontDesign(.monospaced)
    }
    
    
}

