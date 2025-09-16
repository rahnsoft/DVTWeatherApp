//
//  UICGFloat+App.swift
//  WeatherApp
//
//  Created by Nick on 05/08/2025.
//

import UIKit

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
