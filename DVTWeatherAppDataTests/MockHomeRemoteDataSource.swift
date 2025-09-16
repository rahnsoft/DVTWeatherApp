class MockHomeRemoteDataSource: HomeRemoteDataSource {
    var weatherResponseToReturn: WeatherResponse?
    var forecastResponseToReturn: ForecastResponse?
    var placesResponseToReturn: [PlacesResponse] = []
    var errorToReturn: SBErrors?

    override func apiRequest<T>(_ request: URLRequest) -> AnyPublisher<(T, HTTPURLResponse), SBErrors> {
        if let error = errorToReturn {
            return Fail(error: error).eraseToAnyPublisher()
        }

        if T.self == WeatherResponse.self, let response = weatherResponseToReturn as? T {
            return Just((response, HTTPURLResponse())).setFailureType(to: SBErrors.self).eraseToAnyPublisher()
        }

        if T.self == ForecastResponse.self, let response = forecastResponseToReturn as? T {
            return Just((response, HTTPURLResponse())).setFailureType(to: SBErrors.self).eraseToAnyPublisher()
        }

        if T.self == [PlacesResponse].self, let response = placesResponseToReturn as? T {
            return Just((response, HTTPURLResponse())).setFailureType(to: SBErrors.self).eraseToAnyPublisher()
        }

        fatalError("Unhandled type in mock")
    }
}
