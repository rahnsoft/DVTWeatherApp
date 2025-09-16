//
//  UIColor+Data.swift
//  WeatherAppData
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import UIKit

// MARK: - color hex
import UIKit

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        
        guard let hexValue = UInt64(hexString, radix: 16) else {
            return nil
        }
        
        let r, g, b: CGFloat
        
        switch hexString.count {
        case 3:
            r = CGFloat((hexValue >> 8) & 0xF) / 15.0
            g = CGFloat((hexValue >> 4) & 0xF) / 15.0
            b = CGFloat(hexValue & 0xF) / 15.0
        case 6:
            r = CGFloat((hexValue >> 16) & 0xFF) / 255.0
            g = CGFloat((hexValue >> 8) & 0xFF) / 255.0
            b = CGFloat(hexValue & 0xFF) / 255.0
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
