
// MARK: - Enhanced MapView with Weather Overlays
struct EnhancedMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let weatherLayer: WeatherLayerType
    let overlayOpacity: Double
    let apiKey: String
    let annotations: [WeatherData]
    @Binding var selectedLocation: WeatherData?
    let onLocationSelected: (WeatherData) -> Void
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if !mapView.region.center.isEqual(to: region.center, precision: 0.001) {
            mapView.setRegion(region, animated: true)
        }
        
        updateWeatherOverlay(mapView: mapView)
        updateAnnotations(mapView: mapView, context: context)
    }
    
    private func updateWeatherOverlay(mapView: MKMapView) {
        let existingOverlays = mapView.overlays.filter { $0 is WeatherTileOverlay }
        mapView.removeOverlays(existingOverlays)
        
        if weatherLayer != .none {
            let overlay = WeatherTileOverlay(
                layerType: weatherLayer,
                apiKey: apiKey,
                opacity: overlayOpacity
            )
            mapView.addOverlay(overlay, level: .aboveLabels)
        }
    }
    
    private func updateAnnotations(mapView: MKMapView, context: Context) {
        let existingAnnotations = mapView.annotations.compactMap { $0 as? WeatherAnnotation }
        let newAnnotations = annotations.map { WeatherAnnotation(weatherData: $0) }
        
        let annotationsToRemove = existingAnnotations.filter { existing in
            !newAnnotations.contains { $0.weatherData.id == existing.weatherData.id }
        }
        mapView.removeAnnotations(annotationsToRemove)
        
        let annotationsToAdd = newAnnotations.filter { new in
            !existingAnnotations.contains { $0.weatherData.id == new.weatherData.id }
        }
        mapView.addAnnotations(annotationsToAdd)
        context.coordinator.parent = self
    }
    
    func makeCoordinator() -> MapViewDelegate {
        MapViewDelegate(parent: self)
    }
}