//
//  AppointmentsView.swift
//  HealthCare
//
//  Created by Halit İçli on 3.04.2025.
//

import SwiftUI

struct AppointmentView: View {
    @StateObject private var viewModel = AppointmentViewModel()
    @State private var selectedTab: String = "upcoming"
    @State private var sortOption: String = "date"

    var body: some View {
        VStack {
            // Top toggle buttons
            HStack {
                Button(action: {
                    withAnimation {
                        selectedTab = "upcoming"
                    }
                }) {
                    VStack(spacing: 2) {
                        Text("Upcoming")
                            .fontWeight(selectedTab == "upcoming" ? .bold : .regular)
                        Text("(\(viewModel.appointments.filter { $0.status == "upcoming" }.count))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                    .background(selectedTab == "upcoming" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                }
                
                Button(action: {
                    withAnimation {
                        selectedTab = "past"
                    }
                }) {
                    VStack(spacing: 2) {
                        Text("Past")
                            .fontWeight(selectedTab == "past" ? .bold : .regular)
                        Text("(\(viewModel.appointments.filter { $0.status == "past" }.count))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                    .background(selectedTab == "past" ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                }
                Spacer()
            }
            .padding()

            // Animated appointment list view based on selected tab
            ZStack {
                if selectedTab == "upcoming" {
                    AppointmentListView(title: "Upcoming Appointments",
                                        appointments: viewModel.appointments.filter { $0.status == "upcoming" })
                    .transition(.move(edge: .leading))
                } else {
                    AppointmentListView(title: "Past Appointments",
                                        appointments: viewModel.appointments.filter { $0.status == "past" })
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut, value: selectedTab)
        }
    }
}

struct AppointmentListView: View {
    let title: String
    let appointments: [Appointment]

    var body: some View {
        ScrollView {
            LazyVStack(alignment:.leading, spacing: 10) {
                ForEach(appointments) { appointment in
                    AppointmentCardView(appointment: appointment)
                }
            }
            .padding()
        }
    }
}

struct AppointmentCardView: View {
    let appointment: Appointment

    var body: some View {
        HStack {
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
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 3)
            
        }
    }
}

#Preview {
    AppointmentView()
}
