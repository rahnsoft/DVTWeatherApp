final class HomeRepositoryTests: XCTestCase {
    var repository: HomeRepository!
    var remoteMock: MockHomeRemoteDataSource!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        remoteMock = MockHomeRemoteDataSource()
        repository = HomeRepository(homeRemoteDataSource: remoteMock)
        cancellables = []
    }

    override func tearDown() {
        repository = nil
        remoteMock = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetWeatherSuccess() {
        let weather = WeatherResponse(city: "Nairobi", temp: 25.0)
        remoteMock.weatherResponseToReturn = weather
        let expectation = self.expectation(description: "Weather fetched")

        repository.getWeather(0, 0)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { data in
                XCTAssertEqual(data.city, "Nairobi")
                XCTAssertEqual(data.temperature, 25.0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetWeatherFailure() {
        remoteMock.errorToReturn = .networkError
        let expectation = self.expectation(description: "Weather fetch failed")

        repository.getWeather(0, 0)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, SBErrors.networkError)
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Expected failure but got success")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetPlacesSuggestions() {
        let places = [PlacesResponse(name: "Nairobi"), PlacesResponse(name: "Kisii")]
        remoteMock.placesResponseToReturn = places
        let expectation = self.expectation(description: "Places fetched")

        repository.getPlacesSuggestions("N")
            .sink { _ in } receiveValue: { data in
                XCTAssertEqual(data.count, 2)
                XCTAssertEqual(data[0].name, "Nairobi")
                XCTAssertEqual(data[1].name, "Kisii")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}
