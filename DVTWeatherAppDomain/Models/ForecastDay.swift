//
//  ForecastDay.swift
//  WeatherApp
//
//  Created by Nick on 11/09/2025.
//

import CoreLocation
import UIKit

public struct ForecastDay: Codable, Hashable, Identifiable {
    public var id = UUID()
    public var date: Date
    public var condition: WeatherCondition
    public var temperatureHigh: Double
    public var temperatureLow: Double
    public var humidity: Int
    public var windSpeed: Double
    public var precipitationProbability: Double

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: ForecastDay, rhs: ForecastDay) -> Bool {
        lhs.id == rhs.id
    }

    public init(id: UUID = UUID(), date: Date, condition: WeatherCondition, temperatureHigh: Double, temperatureLow: Double, humidity: Int, windSpeed: Double, precipitationProbability: Double) {
        self.id = id
        self.date = date
        self.condition = condition
        self.temperatureHigh = temperatureHigh
        self.temperatureLow = temperatureLow
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.precipitationProbability = precipitationProbability
    }
}
