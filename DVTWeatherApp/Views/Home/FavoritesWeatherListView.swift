import SwiftUI

struct FavoritesWeatherListView: View {
    var favorites: [WeatherData] // Your saved favorite locations
    var onSelectFirst: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            ForEach(favorites.indices, id: \.self) { index in
                CurrentWeatherCardView(viewModel: WeatherViewModel(data: favorites[index]))
                    .onTapGesture {
                        if index == 0 {
                            onSelectFirst()
                        } else {
                            print("Selected favorite at index \(index)")
                            // Optionally handle other favorites
                        }
                    }
                    .frame(height: 150)
            }
        }
    }
}
