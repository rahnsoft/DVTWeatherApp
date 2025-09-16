// MARK: - Location Detail Sheet
struct LocationDetailSheet: View {
    let weatherData: WeatherData
    @Environment(\.dismiss) private var dismiss
    
    private var currentWeather: CurrentWeather? {
        weatherData.currentWeather.first
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text(weatherData.location.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if let country = weatherData.location.country {
                            Text(country)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Text("Coordinates: \(String(format: "%.4f", weatherData.location.coordinate.latitude)), \(String(format: "%.4f", weatherData.location.coordinate.longitude))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    if let weather = currentWeather {
                        WeatherDetailsSection(weather: weather)
                    }
                    
                    if !weatherData.forecast.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(Strings.fiveDayForeCast.text)
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            LazyVStack(spacing: 8) {
                                ForEach(weatherData.forecast.prefix(5)) { forecast in
                                    ForecastRow(day: forecast.toDisplay(), isToday: false)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Text(Strings.lastUpdated.localized(with: "\(weatherData.lastUpdated, style: .relative)"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .navigationTitle("Location Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(Strings.commonDone.text) {
                dismiss()
            })
        }
    }
}

// MARK: - Weather Details Section
struct WeatherDetailsSection: View {
    let weather: CurrentWeather
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(weather.condition.iconName)
                    .resizable()
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(weather.temperature.celsiusString)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(weather.condition.displayName)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(Strings.feelsLike.localized(with: " \(weather.feelsLike.celsiusString)"))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            weatherDetailsGrid(for: weather)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(weather.condition.primaryColor).opacity(0.1))
        )
    }
    
    private func weatherDetailsGrid(for weather: CurrentWeather) -> some View {
            WeatherDetailsGrid(weather: weather)
    }
}
