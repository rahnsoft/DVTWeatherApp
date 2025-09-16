//
//  PlacesResponse.swift
//  DVTWeatherApp
//
//  Created by Nick on 15/09/2025.
//


struct PlacesResponse: BaseDataModel, Codable {
    let name: String?
    let lat, lon: Double?
    let country, state: String?
