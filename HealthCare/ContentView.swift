//
//  ContentView.swift
//  HealthCare
//
//  Created by Halit İçli on 2.04.2025.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

struct ContentView: View {
    @State private var showMenu: Bool = false
    var body: some View {
        ZStack {
            Color(hex: "#f5f5f5")
                .ignoresSafeArea()
                           MenuView()
                .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width, y: 0)
                               .zIndex(2)
            VStack {
                ScrollView(showsIndicators: false) {
                    Header(onGearTap: {
                                            withAnimation(.easeInOut) {
                                                showMenu.toggle()
                                            }
                                        })
                    HealthDetails()
                    AppointmentView()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

