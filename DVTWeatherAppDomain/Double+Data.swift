//
//  Double+Data.swift
//  MyPower
//
//  Created by Nicholas Wakaba on 30/01/2025.
//

import Foundation

extension Double {
    var cleanDouble: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var kelvinToCelsius: Double {
        return self - 273.15
    }
    
    var celsiusString: String {
        return "\(Int(self.kelvinToCelsius))°"
    }

    func formattedNumber() -> String {
        return NSNumber(value: self).formattedNumber()
    }
}

extension Int {
    func formattedNumber() -> String {
        return NSNumber(value: self).formattedNumber()
    }
}
