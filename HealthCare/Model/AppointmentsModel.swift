//
//  AppointmentsModel.swift
//  HealthCare
//
//  Created by Halit İçli on 3.04.2025.
//

import Foundation

struct Appointment: Identifiable, Codable {
    let id: Int
    let status: String
    let patientId: Int
    let doctor: Doctor
    let hospital: Hospital
    let createdAt: String
    let appointmentDate: String

    var appointmentDateFormatted: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: appointmentDate)
    }
}

struct Doctor: Codable {
    let id: Int
    let name: String
    let specialty: String
}

struct Hospital: Codable {
    let id: Int
    let name: String
    let location: String
}

