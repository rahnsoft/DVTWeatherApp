//
//  MainWeatherDataRes.swift
//  WeatherApp
//
//  Created by Nick on 11/09/2025.
//

import UIKit

// MARK: - MainWeatherData

public struct MainWeatherData {
    public var temp: Double
    public var feelsLike: Double
    public var tempMin: Double
    public var tempMax: Double
    public var pressure: Int
    public var humidity: Int
    public var seaLevel: Int
    public var grndLevel: Int

    public init(temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, seaLevel: Int, grndLevel: Int) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
    }
}

// MARK: - WindData

public struct WindData: Codable {
    public var speed: Double
    public var deg: Int
    public var gust: Double

    public init(speed: Double, deg: Int, gust: Double) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

// MARK: - CloudData

public struct CloudData: Codable {
    public var all: Int

    public init(all: Int) {
        self.all = all
    }
}

// MARK: - RainSnowData

public struct RainSnowData: Codable {
    public var oneHour: Double
    public var threeHour: Double

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }

    public init(oneHour: Double, threeHour: Double) {
        self.oneHour = oneHour
        self.threeHour = threeHour
    }
}

// MARK: - SystemData

public struct SystemData: Codable {
    public var type: Int
    public var id: Int
    public var country: String
    public var sunrise: Int
    public var sunset: Int

    public init(type: Int, id: Int, country: String, sunrise: Int, sunset: Int) {
        self.type = type
        self.id = id
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
