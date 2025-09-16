import Combine
import Foundation
import WeatherDomain

class BaseRemoteDataSource {
    private let api: APIClient
    
    init(api: APIClient = APIClient()) {
        self.api = api
    }
    
    func apiRequest<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<(T, HTTPURLResponse), SBErrors> {
        api.request(urlRequest)
            .catch { error -> AnyPublisher<(T, HTTPURLResponse), SBErrors> in
                if let sbError = self.getSBError(error) {
                    switch sbError {
                    case .unauthorized:
                        return Fail(error: sbError).eraseToAnyPublisher()
                    case .invalidPin:
                        return Fail(error: SBErrors.invalidPin).eraseToAnyPublisher()
                    default:
                        return Fail(error: sbError).eraseToAnyPublisher()
                    }
                } else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func apiRequest(_ urlRequest: URLRequest) -> AnyPublisher<HTTPURLResponse, SBErrors> {
        api.request(urlRequest)
            .catch { error -> AnyPublisher<HTTPURLResponse, SBErrors> in
                if let sbError = self.getSBError(error) {
                    switch sbError {
                    case .invalidPin,
                         .unauthorized:
                        return Fail(error: sbError).eraseToAnyPublisher()
                    case .userNotFound:
                        return Fail(error: SBErrors.userNotFound).eraseToAnyPublisher()
                    default:
                        return Fail(error: sbError).eraseToAnyPublisher()
                    }
                } else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Error Handling
    
    private func getSBError(_ error: Error) -> SBErrors? {
        guard case let SBErrors.apiError(code, message, reason, dict) = error else {
            return nil
        }
        switch code {
        case 401:
            return message.isEmpty ? .unauthorized : .apiError(code: code, message: message, reason: reason, dict: dict)
        case 403:
            return .userBlacklisted
        case 404:
            return .userNotFound
        case 406:
            return .unauthorized
        default:
            return nil
        }
    }
}
