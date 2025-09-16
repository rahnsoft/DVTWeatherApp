//
//  TimeInterval+App.swift
//  WeatherApp
//
//  Created by Nick on 05/08/2025.
//

import Foundation

extension TimeInterval {
    func string() -> String {
        let time = Int(self)
        _ = (time / 60) % 60
        let hours = (time / 3600)
        var stringTime = ""
        if hours > 1 {
            stringTime = "\(hours) \("hours"))"
        } else if hours == 1 {
            stringTime = "\(hours) \("hours"))"
        }
        return stringTime
    }
}
