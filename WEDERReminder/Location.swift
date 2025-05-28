//
//  Location.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/28/25.
//

import Foundation
import SwiftUI

struct Location: Codable {
    let name: String
    let region: String
    let country: String
}

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    var isRaining: Bool {
        return current.precip_in > 0.0
    }

}

struct CurrentWeather: Codable {
    let temp_f: Double
    let is_day: Int
    let precip_in: Double
    
}

