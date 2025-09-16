import SwiftUI

struct CurrentWeatherCardView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        if let currentWeather = viewModel.currentWeatherData?.currentWeather.first {
            ZStack {
                // Background image
                Image(currentWeather.condition.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    // Top row: Location + Home, Temp
                    HStack {
                        HStack(spacing: 4) {
                            Image(systemName: "house.fill")
                                .foregroundColor(.white)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(viewModel.currentWeatherData?.location.name ?? "Unknown")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("My Location")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        Spacer()
                        Text("\(Int(currentWeather.temperature))°C")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()

                    Spacer()

                    // Bottom row: Condition + desc | H/L temp
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(currentWeather.condition.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(currentWeather.description)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {
                            Text("H: \(Int(currentWeather.temperatureMax))°C")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Text("L: \(Int(currentWeather.temperatureMin))°C")
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                    }
                    .padding()
                }
            }
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding()
        } else {
            Text("Loading weather...")
                .foregroundColor(.gray)
        }
    }
}
