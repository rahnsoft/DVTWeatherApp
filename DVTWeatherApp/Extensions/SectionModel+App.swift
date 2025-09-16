//
//  SectionModel+App.swift
//  WeatherApp
//
//  Created by Nick on 05/08/2025.
//

import Foundation

struct SectionModel<Item>: Identifiable {
    let id = UUID()
    var header: String
    var items: [Item]
    
    var itemsCount: Int {
        items.count
    }
}
