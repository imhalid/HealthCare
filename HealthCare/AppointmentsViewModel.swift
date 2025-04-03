//
//  AppointmentsViewModel.swift
//  HealthCare
//
//  Created by Halit İçli on 3.04.2025.
//

import SwiftUI

class AppointmentViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []

    init() {
        loadAppointments()
    }

    func loadAppointments() {
        guard let url = Bundle.main.url(forResource: "appointments", withExtension: "json") else {
            print("JSON dosyası bulunamadı.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode([String: [Appointment]].self, from: data)
            self.appointments = decodedData["appointments"] ?? []
        } catch {
            print("JSON Decode Hatası:", error)
        }
    }
}

#Preview {
    AppointmentView()
}
