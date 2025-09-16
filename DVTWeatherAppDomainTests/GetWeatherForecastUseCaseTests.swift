//
//  GetWeatherForecastUseCaseTests.swift
//  DVTWeatherApp
//
//  Created by Nick on 16/09/2025.
//


import XCTest
import Combine
@testable import DVTWeatherAppDomain
@testable import DVTWeatherAppData

final class GetWeatherForecastUseCaseTests: XCTestCase {
    var mockRepo: MockHomeRepository!
    var getForecastUseCase: GetWeatherForecastUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepo = MockHomeRepository()
        getForecastUseCase = GetWeatherForecastUseCase(mockRepo)
        cancellables = []
    }

    override func tearDown() {
        mockRepo = nil
        getForecastUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetForecastSuccess() {
        let forecastData = makeWeatherData()
        mockRepo.forecastToReturn = Just(forecastData)
            .setFailureType(to: SBErrors.self)
            .eraseToAnyPublisher()

        let expectation = self.expectation(description: "Forecast returned")

        getForecastUseCase.invoke(-1.2921, 36.8219)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { data in
                XCTAssertEqual(data.location.name, "Nairobi")
                XCTAssertEqual(data.currentWeather.first?.temperature, 25)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetForecastFailure() {
        mockRepo.forecastToReturn = Fail(error: SBErrors.internetError)
            .eraseToAnyPublisher()

        let expectation = self.expectation(description: "Forecast error returned")

        getForecastUseCase.invoke(-1.2921, 36.8219)
            .sink { completion in
                if case .failure(let error) = completion {
                    if case SBErrors.internetError = error {
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected internetError but got \(error)")
                    }
                }
            } receiveValue: { _ in
                XCTFail("Expected failure but got success")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    private func makeWeatherData() -> WeatherData {
        // same as previous helper
        WeatherData(
            id: UUID(),
            location: LocationInfo(
                name: "Nairobi",
                country: "KE",
                coordinate: .init(latitude: -1.2921, longitude: 36.8219),
                timezone: TimeZone(secondsFromGMT: 10800)
            ),
            currentWeather: [CurrentWeather(
                temperature: 25,
                temperatureMin: 23,
                temperatureMax: 27,
                feelsLike: 24,
                humidity: 60,
                pressure: 1012,
                windSpeed: 5,
                windDirection: 180,
                visibility: 10000,
                uvIndex: nil,
                condition: .clear,
                sunrise: Date(),
                sunset: Date(),
                description: "Sunny"
            )],
            forecast: [],
            lastUpdated: Date()
        )
    }
}
