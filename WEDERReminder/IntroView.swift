//
//  IntroView.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/23/25.
//

import SwiftUI
import SwiftData

struct IntroView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("displayModeToggleSelected") private var displayModeToggleSelected: Bool = false
    
    @State private var step = 0
    @State private var showText = true
    @State private var showButton = false
    @State private var isLongMessage = false
    
    let messages = [
        "Welcome",
        "This is WEDER.",
        "You can look at a cities weather, if it's raining, night or day and temperature. You can also make an outfit depending on what the weather will be of where you're going!",
        "Ready to get started?"
    ]
    
    var body: some View {
        NavigationView {
            NavigationStack {
                ZStack {
                    BackgroundView()
                    
                    VStack(spacing: 20) {
                        
                        Spacer()
                        
                        if showText {
                            Text(messages[step])
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .transition(.move(edge: .trailing))
                                .id(step)
                        }
                        
                        Spacer()
                        
                        if showButton {
                            Text("Select Begin to Start!")
                                .foregroundStyle(.white)
                            NavigationLink(destination: MainView()) {
                                Text("Begin")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(isDarkMode ? .white : .black)
                                    .foregroundColor(isDarkMode ? .black : .white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            .transition(.opacity)
                        }
                    }
                    .fontDesign(.monospaced)
                    .onAppear {
                        showNextStep()
                    }
                }
                .fontDesign(.monospaced)
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
            .overlay(alignment: .topTrailing) {
                Toggle("", isOn: $isDarkMode )
                    .labelsHidden()
                    .padding()
            }
    }
    
    func showNextStep() {
        if step < messages.count - 1 {
            if messages[step].count > 15 {
                self.isLongMessage = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (isLongMessage ? 10 : 5)) {
                withAnimation {
                    showText = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    step += 1
                    withAnimation {
                        showText = true
                    }
                    showNextStep()
                }
            }
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    showText = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        showButton = true
                    }
                }
            }
        }
    }
}

