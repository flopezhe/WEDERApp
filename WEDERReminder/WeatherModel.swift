//
//  WeatherModel.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/28/25.
//
import Foundation
import SwiftUI


class WeatherViewModel: ObservableObject {
    @Published var temperatureF: Double?
    @Published var isDay: Bool = true
    @Published var isRaining: Bool = false
    private var URLstring: String = ""
    
    func fetchWeather(for city: String) {
        if let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiKey = dict["WeatherAPIKey"] as? String {
            let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
            URLstring = urlString
        }
        
        guard let url = URL(string: URLstring) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    
        let errorsToCheck = ["500", "400", "401", "404", "429", "403", "501", "502"]
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error, let response = response {
                if (errorsToCheck.contains(error.localizedDescription) || errorsToCheck.contains(response.description)) {
                    return
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    return
                }
            }
            
            guard let data = data else {
                print("No data returned from server")
                return
            }
            
            
            do {
                let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)

                DispatchQueue.main.async {
                    self.temperatureF = decodedResponse.current.temp_f
                    self.isDay = decodedResponse.current.is_day == 1
                    self.isRaining = decodedResponse.current.precip_in > 0.0
                }

            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }

}

