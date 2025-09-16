//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Nick on 11/09/2025.
//
import UIKit

public struct WeatherInfo: Codable {
    public var id: Int
    public var main: String
    public var description: String
    public var icon: String
    
    public init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}
