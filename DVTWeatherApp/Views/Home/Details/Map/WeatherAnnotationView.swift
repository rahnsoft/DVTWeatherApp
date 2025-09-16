//
//  WeatherTileOverlay.swift
//  DVTWeatherApp
//
//  Created by Nick on 16/09/2025.
//


class WeatherTileOverlay: MKTileOverlay {
    let layerType: WeatherLayerType
    let apiKey: String
    let opacity: Double
    
    init(layerType: WeatherLayerType, apiKey: String, opacity: Double) {
        self.layerType = layerType
        self.apiKey = apiKey
        self.opacity = opacity
        super.init(urlTemplate: nil)
        
        self.urlTemplate = "https://tile.openweathermap.org/map/\(layerType.rawValue)/{z}/{x}/{y}.png?appid=\(apiKey)"
        self.canReplaceMapContent = false
    }
}

class WeatherTileRenderer: MKTileOverlayRenderer {
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        super.draw(mapRect, zoomScale: zoomScale, in: context)
        
        if let overlay = self.overlay as? WeatherTileOverlay {
            context.setAlpha(CGFloat(overlay.opacity))
        }
    }
}

// MARK: - Weather Annotation
class WeatherAnnotation: NSObject, MKAnnotation {
    let weatherData: WeatherData
    
    var coordinate: CLLocationCoordinate2D {
        weatherData.location.coordinate
    }
    
    var title: String? {
        weatherData.location.name
    }
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
    }
}

// MARK: - Weather Annotation View
struct WeatherAnnotationView: View {
    let weatherData: WeatherData
    let isSelected: Bool
    
    private var currentWeather: CurrentWeather? {
        weatherData.currentWeather.first
    }
    
    var body: some View {
        VStack(spacing: 2) {
            VStack(spacing: 2) {
                if let weather = currentWeather {
                    Image(weather.condition.iconName)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Text(weather.temperature.celsiusString)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(8)
            .background(
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(currentWeather?.condition.primaryColor ?? "CloudyPrimary"),
                                Color(currentWeather?.condition.primaryColor ?? "CloudyPrimary").opacity(0.8)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
            )
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: isSelected ? 3 : 0)
            )
            .scaleEffect(isSelected ? 1.2 : 1.0)
            .animation(.spring(response: 0.3), value: isSelected)
            
            Text(weatherData.location.name)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                )
        }
    }
}

// MARK: - Weather Layer Legend
struct WeatherLayerLegend: View {
    let layerType: WeatherLayerType
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: layerType.iconName)
                .font(.system(size: 14))
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(layerType.displayName)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(legendText)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.7))
        )
    }
    
    private var legendText: String {
        switch layerType {
        case .none: return ""
        case .temperature: return "°C"
        case .precipitation: return "mm/h"
        case .pressure: return "hPa"
        case .wind: return "m/s"
        case .clouds: return "%"
        }
    }
}

