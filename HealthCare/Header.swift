//
//  Header.swift
//  HealthCare
//
//  Created by Halit İçli on 2.04.2025.
//

import SwiftUI

extension View {
    func iconStyle() -> some View {
        self
            .scaledToFit()
            .frame(width: 24, height: 24)
            .imageScale(.large)
            .padding(10)
            .foregroundStyle(.black)
            .background(.gray.opacity(0.05))
            .clipped()
            .clipShape(Circle())
            
        
    }
}

struct Header: View {
    let onGearTap: () -> Void
    var body: some View {
        HStack {
            Image(systemName: "person")
                .iconStyle()
            VStack(alignment: .leading) {
                Text("Welcome")
                    .font(.system(size: 18))
                    .fontWeight(.light)
                    .foregroundStyle(.primary)
                Text("Jhon Doe")
                    .fontWeight(.medium)
                    .font(.system(.title3, design: .rounded))
            }
            Spacer()
            HStack{
                Image(systemName: "bell")
                    .iconStyle()
                
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .imageScale(.large)
                    .padding(10)
                    .foregroundStyle(.black)
                    .zIndex(5)
                    .onTapGesture {
                        withAnimation {
                            onGearTap()
                        }
                            }
            }
        }.padding()
            
    }
}

#Preview {
    Header(onGearTap: { })
}
