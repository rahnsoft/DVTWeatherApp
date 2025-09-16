import UIKit
import SwiftUI

class WeatherViewController: UIViewController, UISearchResultsUpdating {

    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Setup navigation title
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter city name"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Add WeatherView (SwiftUI) as a child
        let weatherView = UIHostingController(rootView: WeatherView(cityName: "Nairobi"))
        addChild(weatherView)
        weatherView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherView.view)
        NSLayoutConstraint.activate([
            weatherView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        weatherView.didMove(toParent: self)
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let city = searchController.searchBar.text, !city.isEmpty else { return }
        print("Search for city:", city)
        // Call your weather API here with the `city` value
    }
}

// Example SwiftUI WeatherView
struct WeatherView: View {
    var cityName: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Weather in \(cityName)")
                .font(.title)
                .bold()
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            Text("28°C")
                .font(.largeTitle)
        }
        .padding()
    }
}
