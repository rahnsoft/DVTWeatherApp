//
//  Coordinates.swift
//  WeatherApp
//
//  Created by Nick on 11/09/2025.
//

import UIKit

public struct Coordinates: Codable {
    public var lon: Double
    public var lat: Double
    
    public init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}
