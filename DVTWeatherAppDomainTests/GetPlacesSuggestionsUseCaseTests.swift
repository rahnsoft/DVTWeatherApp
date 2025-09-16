import XCTest
import Combine
@testable import DVTWeatherAppDomain
@testable import DVTWeatherAppData

final class GetPlacesSuggestionsUseCaseTests: XCTestCase {
    var mockRepo: MockHomeRepository!
    var getPlacesUseCase: GetPlacesSuggestionsUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepo = MockHomeRepository()
        getPlacesUseCase = GetPlacesSuggestionsUseCase(mockRepo)
        cancellables = []
    }

    override func tearDown() {
        mockRepo = nil
        getPlacesUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetPlacesSuccess() {
        let places = [
            PlacesData(name: "Nairobi", lat: -1.2921, lon: 36.8219, country: "KE", state: "Nairobi County"),
            PlacesData(name: "Kisii", lat: -0.6800, lon: 34.7700, country: "KE", state: "Kisii County")
        ]
        mockRepo.placesToReturn = Just(places)
            .setFailureType(to: SBErrors.self)
            .eraseToAnyPublisher()

        let expectation = self.expectation(description: "Places returned")

        getPlacesUseCase.invoke("N")
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            } receiveValue: { data in
                XCTAssertEqual(data.count, 2)
                XCTAssertEqual(data[0].name, "Nairobi")
                XCTAssertEqual(data[1].name, "Kisii")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetPlacesFailure() {
        mockRepo.placesToReturn = Fail(error: SBErrors.internetError)
            .eraseToAnyPublisher()

        let expectation = self.expectation(description: "Places error returned")

        getPlacesUseCase.invoke("N")
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
}
