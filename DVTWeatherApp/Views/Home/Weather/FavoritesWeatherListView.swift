//
//  FavoritesWeatherListView.swift
//  DVTWeatherApp
//
//  Created by Nick on 15/09/2025.
//

import DVTWeatherAppDomain
import SwiftUI

// MARK: - FavoritesWeatherListView

struct FavoritesListView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var onSelect: (Int) -> Void

    var body: some View {
        List {
            ForEach(viewModel.favoriteWeather.indices, id: \.self) { index in
                FavoriteWeatherCardRow(currentWeatherData: viewModel.favoriteWeather[index])
                    .frame(height: 120)
                    .onTapGesture { onSelect(index) }
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - FavoriteWeatherCardRow

struct FavoriteWeatherCardRow: View {
    var currentWeatherData: WeatherData

    var body: some View {
        CurrentWeatherCardView(currentWeatherData: currentWeatherData)
    }
}
