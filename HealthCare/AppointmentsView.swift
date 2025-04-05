//
//  AppointmentsView.swift
//  HealthCare
//
//  Created by Halit İçli on 3.04.2025.
//

import SwiftUI

struct AppointmentView: View {
    @StateObject private var viewModel = AppointmentViewModel()
    @State private var selectedTab: String = "all"
    @State private var sortOption: String = "date"

    var body: some View {
        VStack {
            // Top toggle buttons
            HStack {
                Button(action: {
                    withAnimation {
                        selectedTab = "all"
                    }
                }) {
                    HStack(spacing: 2) {
                        Text("All")
                            .foregroundStyle(selectedTab == "all" ? .white : .blue)
                        Text("(\(viewModel.appointments.count))")
                            .font(.caption)
                            .foregroundColor(selectedTab == "all" ? .white : .blue)
                    }
                    .padding(8)
                    .background(selectedTab == "all" ? Color.blue : Color.clear)
                    .cornerRadius(8)
                }
                
                Button(action: {
                    withAnimation {
                        selectedTab = "upcoming"
                    }
                }) {
                    HStack(spacing: 2) {
                        Text("Upcoming")
                            .foregroundStyle(selectedTab == "upcoming" ? .white : .blue)
                        Text("(\(viewModel.appointments.filter { $0.status == "upcoming" }.count))")
                            .font(.caption)
                            .foregroundColor(selectedTab == "upcoming" ? .white : .blue)
                    }
                    .padding(8)
                    .background(selectedTab == "upcoming" ? Color.blue : Color.clear)
                    .cornerRadius(8)
                }
                
                Button(action: {
                    withAnimation {
                        selectedTab = "past"
                    }
                }) {
                    HStack(spacing: 2) {
                        Text("Past")
                            .foregroundStyle(selectedTab == "past" ? .white : .blue)
                        Text("(\(viewModel.appointments.filter { $0.status == "past" }.count))")
                            .font(.caption)
                            .foregroundColor(selectedTab == "past" ? .white : .blue)
                    }
                    .padding(8)
                    .background(selectedTab == "past" ? Color.blue : Color.clear)
                    .cornerRadius(8)
                }
                
                
                Spacer()
            }
            .padding(.horizontal)

            // Animated appointment list view based on selected tab
            ZStack {
                Group {
                    if selectedTab == "upcoming" {
                        AppointmentListView(title: "Upcoming Appointments",
                                            appointments: viewModel.appointments.filter { $0.status == "upcoming" })
                    } else if selectedTab == "past" {
                        AppointmentListView(title: "Past Appointments",
                                            appointments: viewModel.appointments.filter { $0.status == "past" })
                    } else {
                        AppointmentListView(
                            title: "All",
                            appointments: viewModel.appointments
                                .sorted(by: { $0.appointmentDateFormatted ?? Date() > $1.appointmentDateFormatted ?? Date() }))
                    }
                }
                .transition(.identity)
                .id(selectedTab) // force transition by changing view identity
            }
            .animation(.easeInOut, value: selectedTab)
        }
    }
}

struct AppointmentListView: View {
    let title: String
    let appointments: [Appointment]

    var body: some View {
            LazyVStack(alignment:.leading, spacing: 10) {
                ForEach(appointments) { appointment in
                    AppointmentCardView(appointment: appointment)
                }
            }
            .padding(.horizontal)
    }
}

struct AppointmentCardView: View {
    let appointment: Appointment

    var body: some View {
        
        ZStack {
            Rectangle()
                .zIndex(1)
                .foregroundStyle(
                    appointment.status == "upcoming" ? LinearGradient(
                        colors: [.blue.opacity(0.1), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    ) : LinearGradient(
                        colors: [.gray.opacity(0.1), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack {
                Rectangle()
                    .foregroundStyle(appointment.status == "upcoming" ? Color.blue : Color.gray)
                    .blur(radius: 1)
                    .frame(width: 5, height: 100)
                    
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(appointment.doctor.name) - \(appointment.doctor.specialty)")
                        .font(.headline)
                    
                    Text(appointment.hospital.name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    if let date = appointment.appointmentDateFormatted {
                        Text("Date: \(date, style: .date) \(date, style: .time)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .clipped()
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
        }
    }
}

#Preview {
    AppointmentView()
}
