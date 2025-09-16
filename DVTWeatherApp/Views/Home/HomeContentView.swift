import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            
            // MARK: - Map Tab
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                .tag(0)
            
            // MARK: - Weather Tab
            NavigationView {
                WeatherView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        // Left: Map button
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                selection = 0 // Switch to Map tab
                            }) {
                                Image(systemName: "map")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Right: Menu button
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                print("Menu tapped")
                                // You can trigger a menu or dismiss
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .foregroundColor(.white)
                            }
                        }
                    }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Weather")
            }
            .tag(1)
        }
        .accentColor(.white)
    }
}

// MARK: - MapView Placeholder
struct MapView: View {
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            Text("Map View")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
    }
}

// MARK: - Preview
struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
            .environmentObject(WeatherViewModel(
                GetWeatherUseCaseMock(),
                GetWeatherForecastUseCaseMock()
            ))
    }
}
