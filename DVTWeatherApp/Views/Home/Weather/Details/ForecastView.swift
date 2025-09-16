//
//  ForecastDay.swift
//  DVTWeatherApp
//
//  Created by Nick on 15/09/2025.
//

import DVTWeatherAppDomain
import Foundation
import SwiftUI

// MARK: - ForecastView

struct ForecastView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            headerView
            forecastListView
        }
    }
    
    // MARK: - Header View

    private var headerView: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.white.opacity(0.8))
            
            Text(Strings.fiveDayForeCast.text)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal, 4)
    }
    
    // MARK: - Forecast List View

    private var forecastListView: some View {
        VStack(spacing: 1) {
            ForEach(Array(viewModel.forecastDisplays.enumerated()), id: \.offset) { index, day in
                ForecastRowView(
                    day: day,
                    isToday: index == 0
                )
            }
        }
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - ForecastRowView

struct ForecastRowView: View {
    let day: ForecastDayDisplay
    let isToday: Bool

    private let dayColumnWidth: CGFloat = 80

    var body: some View {
        HStack {
            Text(day.dayName)
                .font(.system(size: 16, weight: isToday ? .semibold : .medium))
                .foregroundColor(.white)
                .frame(width: dayColumnWidth, alignment: .leading)

            Spacer()

            Image(day.iconName)
                .font(.system(size: 20))
                .foregroundColor(.white.opacity(0.9))
                .frame(width: 30)

            Spacer()

            if day.precipitationProbability != "0%" {
                Text(day.precipitationProbability)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
                    .frame(width: 35)
            } else {
                Spacer().frame(width: 35)
            }

            Spacer()

            HStack(spacing: 16) {
                Text(day.lowTemp)
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.7))

                Text(day.highTemp)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(alignment: .trailing)
            }
            .frame(minWidth: 68)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white.opacity(isToday ? 0.2 : 0.1))
    }
}
