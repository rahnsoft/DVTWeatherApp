import XCTest
import Combine
@testable import DVTWeatherAppDomain

final class MockHomeRepositoryDomain: HomeRepositoryProtocol {
    var weatherToReturn: AnyPublisher<WeatherData, SBErrors> = Empty().eraseToAnyPublisher()
    var forecastToReturn: AnyPublisher<WeatherData, SBErrors> = Empty().eraseToAnyPublisher()
    var placesToReturn: AnyPublisher<[PlacesData], SBErrors> = Empty().eraseToAnyPublisher()

    func getWeather(_ lat: Double, _ lon: Double) -> AnyPublisher<WeatherData, SBErrors> {
        return weatherToReturn
    }

    func getWeatherForecast(_ lat: Double, _ lon: Double) -> AnyPublisher<WeatherData, SBErrors> {
        return forecastToReturn
    }

    func getPlacesSuggestions(_ query: String) -> AnyPublisher<[PlacesData], SBErrors> {
        return placesToReturn
    }
}
