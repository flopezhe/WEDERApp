//
//  File.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/27/25.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        GifImage(isDarkMode ? "giphy" : "giphy-1")
            .id(isDarkMode ? "giphy" : "giphy-1")
            .ignoresSafeArea(edges: .all)
    }
}
