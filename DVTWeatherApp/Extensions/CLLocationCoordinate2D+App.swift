//
//  Location+App.swift
//  DVTWeatherApp
//
//  Created by Nick on 16/09/2025.
//


// MARK: - Extensions
extension CLLocationCoordinate2D {
    func isEqual(to coordinate: CLLocationCoordinate2D, precision: Double) -> Bool {
        abs(latitude - coordinate.latitude) < precision &&
        abs(longitude - coordinate.longitude) < precision
    }
}