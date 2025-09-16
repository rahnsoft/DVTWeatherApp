//
//  LocationInfo.swift
//  WeatherApp
//
//  Created by Nick on 14/09/2025.
//

import CoreLocation
import UIKit

public struct LocationInfo: Codable, Hashable {
    public var id: String
    public var name: String
    public var country: String?
    public var coordinate: CLLocationCoordinate2D
    public var timezone: TimeZone?
    
    public init(id: String = UUID().uuidString,
                name: String,
                country: String? = nil,
                coordinate: CLLocationCoordinate2D,
                timezone: TimeZone? = nil)
    {
        self.id = id
        self.name = name
        self.country = country
        self.coordinate = coordinate
        self.timezone = timezone
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case latitude
        case longitude
        case timezone
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        
        let lat = try container.decode(Double.self, forKey: .latitude)
        let lon = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        if let timezoneString = try container.decodeIfPresent(String.self, forKey: .timezone) {
            timezone = TimeZone(identifier: timezoneString)
        } else {
            timezone = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encodeIfPresent(timezone?.identifier, forKey: .timezone)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: LocationInfo, rhs: LocationInfo) -> Bool {
        lhs.id == rhs.id
    }
}
