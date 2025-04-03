//
//  HealthDetails.swift
//  HealthCare
//
//  Created by Halit İçli on 2.04.2025.
//

import SwiftUI

struct HealthDetails: View {
    // Basic health info with their own colors
    let basicData: [(title: String, value: String)] = [
        ("Blood Type", "O Rh+"),
        ("Height", "170 cm"),
        ("Weight", "65 kg"),
        ("Age", "29"),
    ]

    // Other health info that will remain white
    let otherData: [(title: String, value: String)] = [
        ("BMI", "22.5 (normal)"),
        ("Water Intake", "1.5L / 2.5L"),
        ("Step Count", "4,230 / 8,000"),
        ("Sleep Duration", "6 hours")
    ]

    // Grid layout with two columns
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    struct RoundedCorners: Shape {
        var radius: CGFloat = 16
        var corners: UIRectCorner = [.topRight, .topLeft]
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    var body: some View {
            LazyVGrid(columns: columns, spacing: 8) {
                // Display basic data with individual colors
                ForEach(basicData, id: \ .title) { item in
                    ZStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: iconForBasic(item.title))
                                    .foregroundStyle(colorForBasic(item.title))
                                    .shadow(
                                        color: colorForBasic(item.title).opacity(0.5),
                                        radius: 5
                                    )
                                Text(item.title)
                                    .fontWeight(.medium)
                                
                            }.padding(5)
                        HStack(alignment: .firstTextBaseline) {
                            Text(item.value)
                                .fontWeight(.bold)
                                .foregroundStyle(colorForBasic(item.title))
                                .saturation(0.7)
                            Spacer()
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [
                                    colorForBasic(item.title).opacity(0.3),
                                    colorForBasic(item.title).opacity(0.1)
                                ],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .clipShape(
                            RoundedCorners(radius: 16, corners: [.bottomLeft, .topRight])
                        )
                        .clipShape(
                            RoundedCorners(radius: 8, corners: [.bottomRight, .topLeft])
                        )
                        .overlay {
                            Image(systemName: "chevron.right")
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity,
                                    alignment: .trailing
                                )
                                .padding()
                                .foregroundStyle(colorForBasic(item.title))
                        }
                        }
                    }.padding(2)
                }
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(otherData, id: \ .title) { item in
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .fontWeight(.bold)
                            Spacer()
                            Text(item.value)
                        }
                        .padding()
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        .background(colorForBasic(item.title))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }
                .padding()
                .frame(height: 100)
            }
        
    }

    func colorForBasic(_ title: String) -> Color {
        switch title {
        case "Blood Type":
            return Color.red
        case "Height":
            return Color.blue
        case "Weight":
            return Color.green
        case "Age":
            return Color.orange
        default:
            return Color.white
        }
    }
    
    func iconForBasic(_ title: String) -> String {
        switch title {
        case "Blood Type":
            return "heart.fill"
        case "Height":
            return "ruler.fill"
        case "Weight":
            return "scalemass.fill"
        case "Age":
            return "person.fill"
        default:
            return "questionmark"
        }
    }
}

#Preview {
    HealthDetails()  
}
