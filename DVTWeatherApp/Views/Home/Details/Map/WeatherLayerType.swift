import SwiftUI
import MapKit
import CoreLocation
import DVTWeatherAppDomain

// MARK: - Weather Layer Types
enum WeatherLayerType: String, CaseIterable {
    case none = ""
    case temperature = "temp_new"
    case precipitation = "precipitation_new"
    case pressure = "pressure_new"
    case wind = "wind_new"
    case clouds = "clouds_new"
    
    var displayName: String {
        switch self {
        case .none: return "None"
        case .temperature: return "Temperature"
        case .precipitation: return "Precipitation"
        case .pressure: return "Pressure"
        case .wind: return "Wind"
        case .clouds: return "Clouds"
        }
    }
    
    var iconName: String {
        switch self {
        case .none: return "eye.slash"
        case .temperature: return "thermometer"
        case .precipitation: return "cloud.rain"
        case .pressure: return "gauge"
        case .wind: return "wind"
        case .clouds: return "cloud"
        }
    }
}