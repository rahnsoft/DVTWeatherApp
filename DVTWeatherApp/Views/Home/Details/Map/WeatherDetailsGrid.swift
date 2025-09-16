struct WeatherDetailsGrid: View {
    let weather: CurrentWeather

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()), GridItem(.flexible())
        ], spacing: 12) {
            WeatherDetailCard(
                icon: "humidity.fill",
                title: Strings.humidityText.text,
                value: "\(weather.humidity)%"
            )

            WeatherDetailCard(
                icon: "wind",
                title: Strings.windSpeed.text,
                value: String(format: "%.1f km/h", weather.windSpeed * 3.6)
            )

            WeatherDetailCard(
                icon: "barometer",
                title: Strings.pressureText.text,
                value: "\(weather.pressure) hPa"
            )

            if let visibility = weather.visibility {
                WeatherDetailCard(
                    icon: "eye",
                    title: Strings.visibilityText.text,
                    value: String(format: "%.1f km", Double(visibility) / 1000)
                )
            }

            if let uvIndex = weather.uvIndex {
                WeatherDetailCard(
                    icon: "sun.max",
                    title: Strings.uvIndexText.text,
                    value: String(format: "%.1f", uvIndex)
                )
            }
        }
        .padding(.top, 32)
    }
}
