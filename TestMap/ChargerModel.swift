//
//  ChargerModel.swift
//  TestMap
//
//  Created by admin on 29.09.2022.
//

import Foundation

struct ChargerModel: Codable {
    let status: String
    let chargelocations: [Chargelocation]
}

// MARK: - Chargelocation
struct Chargelocation: Codable {
    let chargepoints: [Chargepoint]
    let geID: Int
    let name: String
    let address: Address
    let coordinates: Coordinates
    let network, url: String
    let faultReport, verified: Bool

    enum CodingKeys: String, CodingKey {
        case chargepoints
        case geID = "ge_id"
        case name, address, coordinates, network, url
        case faultReport = "fault_report"
        case verified
    }
}

// MARK: - Address
struct Address: Codable {
    let city, country, postcode, street: String
}

// MARK: - Chargepoint
struct Chargepoint: Codable {
    let type: String
    let power, count: Int
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lat, lng: Double
}
