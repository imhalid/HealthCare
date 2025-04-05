//
//  Menu.swift
//  HealthCare
//
//  Created by Halit İçli on 5.04.2025.
//

import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
}

struct MenuView: View {
    let menuItems: [MenuItem] = [
        MenuItem(iconName: "person", title: "Profile"),
        MenuItem(iconName: "calendar", title: "Appointments"),
        MenuItem(iconName: "gear", title: "Settings"),
        MenuItem(iconName: "arrow.backward.square", title: "Logout")
    ]
    
    var body: some View {
        VStack {
            ForEach(menuItems) { item in
                NavigationLink(destination: Text(item.title)) {
                    MenuItemView(iconName: item.iconName, title: item.title)
                        .padding(.horizontal)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .ignoresSafeArea()
            .background(.regularMaterial)
    }
}

struct MenuItemView: View {
    let iconName: String
    let title: String

    var body: some View {
    
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.primary.opacity(0.4))
                Text(title)
                    .foregroundColor(.blue)
                    .font(.system(size: 28, weight: .medium))
                    .padding(.leading, 8)
                
            }
            
            .padding(.vertical, 8)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MenuView()
}
