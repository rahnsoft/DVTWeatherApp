//
//  LoginUseCase.swift
//  DVTWeatherAppDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import Combine

public class GetWeatherUseCase: GetWeatherUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol

    public init(_ homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    public func invoke(_ lat: Double, _ lon: Double) -> AnyPublisher<WeatherData, SBErrors> {
        return homeRepository.getWeather(lat, lon)
    }
}
