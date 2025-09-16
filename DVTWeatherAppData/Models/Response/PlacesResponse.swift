//
//  Welcome.swift
//  DVTWeatherApp
//
//  Created by Nick on 15/09/2025.
//

import Foundation

// MARK: - Welcome

struct PlacesResponse: Codable {
    let name: String?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
}
