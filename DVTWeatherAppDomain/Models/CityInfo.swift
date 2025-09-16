//
//  CityInfo.swift
//  WeatherApp
//
//  Created by Nick on 11/09/2025.
//

import UIKit

public struct CityInfo: Codable {
    public var id: Int
    public var name: String
    public var coord: Coordinates
    public var country: String
    public var population: Int
    public var timezone: Int
    public var sunrise: Int
    public var sunset: Int
    
    public init(id: Int, name: String, coord: Coordinates, country: String, population: Int, timezone: Int, sunrise: Int, sunset: Int) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
