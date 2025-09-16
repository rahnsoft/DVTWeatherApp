//
//  MapView.swift
//  DVTWeatherApp
//
//  Created by Nick on 16/09/2025.
//


import MapKit
import SwiftUI

// MARK: - MapView

struct MapView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
    )
    
    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: weatherViewModel.favoriteWeather) { location in
            MapAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: location.coord.lat,
                    longitude: location.coord.lon
                )
            ) {
                VStack(spacing: 2) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                    Text(location.name)
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .fixedSize()
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            if let current = weatherViewModel.currentUserWeatherData {
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: current.coord.lat,
                        longitude: current.coord.lon
                    ),
                    span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
                )
            }
        }
    }
}
