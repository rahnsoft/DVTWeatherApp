//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Nick on 11/09/2025.
//

import UIKit

// MARK: - CurrentWeather

public struct CurrentWeather: Hashable {
    public var temperature: Double
    public var temperatureMin: Double
    public var temperatureMax: Double
    public var feelsLike: Double
    public var humidity: Int
    public var pressure: Int
    public var windSpeed: Double
    public var windDirection: Int?
    public var visibility: Int?
    public var uvIndex: Double?
    public var condition: WeatherCondition
    public var sunrise: Date?
    public var sunset: Date?

    public init(temperature: Double, temperatureMin: Double, temperatureMax: Double, feelsLike: Double, humidity: Int, pressure: Int, windSpeed: Double, windDirection: Int? = nil, visibility: Int? = nil, uvIndex: Double? = nil, condition: WeatherCondition, sunrise: Date? = nil, sunset: Date? = nil) {
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.pressure = pressure
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.visibility = visibility
        self.uvIndex = uvIndex
        self.condition = condition
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

// MARK: - WeatherCondition

public enum WeatherCondition: String, CaseIterable, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case drizzle = "Drizzle"
    case thunderstorm = "Thunderstorm"
    case snow = "Snow"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"

    public init(fromAPIValue value: String) {
        switch value.lowercased() {
        case "clear": self = .clear
        case "clouds",
             "few clouds": self = .clouds
        case "rain",
             "light rain",
             "moderate rain",
             "heavy rain": self = .rain
        case "drizzle": self = .drizzle
        case "thunderstorm": self = .thunderstorm
        case "snow",
             "light snow",
             "heavy snow": self = .snow
        case "mist": self = .mist
        case "smoke": self = .smoke
        case "haze": self = .haze
        case "dust": self = .dust
        case "fog": self = .fog
        case "sand": self = .sand
        case "ash": self = .ash
        case "squall": self = .squall
        case "tornado": self = .tornado
        default: self = .clear
        }
    }

    public var displayName: String {
        switch self {
        case .clear:
            return "Clear Sky"
        case .clouds:
            return "Cloudy"
        case .rain:
            return "Rainy"
        case .drizzle:
            return "Light Rain"
        case .thunderstorm:
            return "Thunderstorm"
        case .snow:
            return "Snow"
        case .mist,
             .fog:
            return "Foggy"
        case .smoke,
             .haze,
             .dust,
             .sand,
             .ash: return "Hazy"
        case .squall: return "Windy"
        case .tornado: return "Severe Weather"
        }
    }

    public var backgroundImageName: String {
        switch self {
        case .clear:
            return "forest_sunny"
        case .clouds,
             .mist,
             .fog,
             .haze:
            return "forest_cloudy"
        case .rain,
             .drizzle,
             .thunderstorm,
             .squall,
             .snow:
            return "forest_rainy"
        default:
            return "forest_cloudy"
        }
    }

    public var iconName: String {
        switch self {
        case .clouds:
            return "partlysunny"
        case .rain,
             .drizzle,
             .thunderstorm,
             .snow,
             .mist,
             .fog,
             .tornado:
            return "rain"
        case .clear,
             .smoke,
             .haze,
             .dust,
             .sand,
             .ash,
             .squall:
            return "clear"
        }
    }

    public var primaryColor: String {
        switch self {
        case .clear: return "SunnyPrimary"
        case .clouds,
             .mist,
             .fog,
             .haze,
             .smoke,
             .dust,
             .sand,
             .ash:
            return "CloudyPrimary"
        case .rain,
             .drizzle,
             .thunderstorm,
             .squall,
             .tornado,
             .snow:
            return "RainyPrimary"
        }
    }
}
