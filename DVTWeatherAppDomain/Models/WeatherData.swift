//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Nick on 11/09/2025.
//
import UIKit
import CoreLocation

public struct WeatherData: Hashable {
    public var id: UUID
    public var location: LocationInfo
    public var currentWeather: [CurrentWeather]
    public var forecast: [ForecastDay]
    public var lastUpdated: Date
    
   public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        lhs.id == rhs.id
    }
    
    public init(id: UUID, location: LocationInfo, currentWeather: [CurrentWeather], forecast: [ForecastDay], lastUpdated: Date) {
        self.id = id
        self.location = location
        self.currentWeather = currentWeather
        self.forecast = forecast
        self.lastUpdated = lastUpdated
    }
}
