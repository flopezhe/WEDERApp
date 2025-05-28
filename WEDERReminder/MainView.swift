//
//  MainView.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/23/25.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    
                    NavigationLink(destination: WeatherView()) {
                        Text("Weather")
                            .fontDesign(.monospaced)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isDarkMode ? Color.white : Color.black)
                            .foregroundColor(isDarkMode ? .black : .white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    NavigationLink(destination: OutfitsView()) {
                        Text("Outfits")
                            .fontDesign(.monospaced)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isDarkMode ? Color.white : Color.black)
                            .foregroundColor(isDarkMode ? .black : .white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .toolbar {
                        // For now I will stick with not using toolbar for UI purposes, saving this incase needed for future use as a base
//                            ToolbarItemGroup(placement: .topBarLeading) {
//                                NavigationLink(destination: WeatherView()) {
//                                    Text("Weather")
//                                        .foregroundColor(isDarkMode ? .black : .white)
//                                        .fontDesign(.monospaced)
//                                }
//
//                                NavigationLink(destination: OutfitsView()) {
//                                    Text("Outfits")
//                                        .foregroundColor(isDarkMode ? .black : .white)
//                                        .fontDesign(.monospaced)
//                                }
//                            }
                            
                        ToolbarItem(placement: .principal) {
                            Text("WEDER")
                                .fontDesign(.monospaced)
                        }
                    }
                    .navigationBarBackButtonHidden()
                    .fontDesign(.monospaced)
                }
            }.fontDesign(.monospaced)
        }
    }
}

#Preview {
    MainView()
}
