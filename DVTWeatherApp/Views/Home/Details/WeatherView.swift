//
//  WeatherView.swift
//  DVTWeatherApp
//
//  Created by Nick on 14/09/2025.
//

import SwiftUI

// MARK: - WeatherBackground

struct WeatherBackground: View {
    let imageName: String
    let color: Color

    var body: some View {
        GeometryReader { geo in
            ZStack {
                color
                    .ignoresSafeArea(.all)

                VStack(spacing: 0) {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height * 0.5)
                        .clipped()
                        .ignoresSafeArea(edges: .top)

                    Spacer(minLength: 0)
                }
            }
        }
    }
}

// MARK: - WeatherView

struct WeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        let currentWeather = viewModel.currentWeatherData?.currentWeather.first

        ZStack {
            WeatherBackground(
                imageName: currentWeather?.condition.backgroundImageName ?? "forest_sunny",
                color: Color(currentWeather?.condition.primaryColor ?? "SunnyPrimary")
            )
            
            VStack {
                headerView
                    .padding(.top, 48)
                
                Spacer()
                
                VStack(spacing: 8) {
                    HStack(spacing: 16) {
                        Image(currentWeather?.condition.iconName ?? "clear")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Text(currentWeather?.temperature.celsiusString ?? "0°")
                            .font(.system(size: 58, weight: .thin))
                            .foregroundColor(.white)
                    }
                    
                    Text(currentWeather?.condition.displayName ?? "")
                        .font(.title2)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    
                    Text(Strings.feelsLike.localized(with: "\(currentWeather?.feelsLike.celsiusString ?? "0"), \(currentWeather?.description ?? "")"))
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 24)
                
                Spacer()
                
                minMaxRow
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        weatherDetailsView
                        
                        if !(viewModel.currentWeatherData?.forecast.isEmpty ?? false) {
                            ForecastView()
                                .environmentObject(viewModel)
                        }
                    }
                    .padding(.bottom, 10 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 80))
                }
                
                if viewModel.isOffline {
                    offlineIndicatorView
                        .padding()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom)
        }
    }

    // MARK: - Header

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let lastUpdated = viewModel.currentWeatherData?.lastUpdated {
                Text(lastUpdated.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let location = viewModel.currentWeatherData?.location {
                Text("\(location.name), \(location.country ?? "")")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(Strings.unknownLocation.localized())
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    // MARK: - Min/Max Row

    private var minMaxRow: some View {
        let currentWeather = viewModel.currentWeatherData?.currentWeather.first
        return HStack {
            VStack {
                Text(currentWeather?.temperatureMin.celsiusString ?? "0°")
                Text(Strings.minText.text).font(.caption)
            }
            Spacer()
            VStack {
                Text(currentWeather?.temperature.celsiusString ?? "0°")
                Text(Strings.currentText.text).font(.caption)
            }
            Spacer()
            VStack {
                Text(currentWeather?.temperatureMax.celsiusString ?? "0°")
                Text(Strings.maxText.text).font(.caption)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
    }

    // MARK: - Details Grid

    private var weatherDetailsView: some View {
        let currentWeather = viewModel.currentWeatherData?.currentWeather.first
        return LazyVGrid(columns: [
            GridItem(.flexible()), GridItem(.flexible())
        ], spacing: 12) {
            if let weather = currentWeather {
                WeatherDetailCard(icon: "humidity.fill", title: Strings.humidityText.text, value: "\(weather.humidity)%")
                WeatherDetailCard(icon: "wind", title: Strings.windSpeed.text, value: String(format: "%.1f km/h", weather.windSpeed * 3.6))
                WeatherDetailCard(icon: "barometer", title: Strings.pressureText.text, value: "\(weather.pressure) hPa")
                if let visibility = weather.visibility {
                    WeatherDetailCard(icon: "eye", title: Strings.visibilityText.text, value: String(format: "%.1f km", Double(visibility) / 1000))
                }
            }
        }.padding(.top, 32)
    }

    // MARK: - Offline Banner

    private var offlineIndicatorView: some View {
        HStack {
            Image(systemName: "wifi.slash")
            Text(Strings.offlineCachedData.text)
        }
        .font(.caption)
        .foregroundColor(.orange)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.black.opacity(0.3))
        .cornerRadius(8)
    }
}

// MARK: - WeatherDetailCard

struct WeatherDetailCard: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white.opacity(0.8))

            Text(title)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.7))

            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
