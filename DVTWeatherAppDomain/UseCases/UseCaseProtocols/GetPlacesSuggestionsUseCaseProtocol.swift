//
//  GetCoinDetailsUseCaseProtocol.swift
//  DVTWeatherAppDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import Combine

public protocol GetWeatherUseCaseProtocol {
    func invoke(_ lat: Double, _ lon: Double) -> AnyPublisher<WeatherData, SBErrors>
}
