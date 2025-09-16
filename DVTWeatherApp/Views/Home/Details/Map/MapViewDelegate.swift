//
//  MapViewDelegate.swift
//  DVTWeatherApp
//

import MapKit
import SwiftUI
import DVTWeatherAppDomain

class MapViewDelegate: NSObject, MKMapViewDelegate {
    var parent: EnhancedMapView
    
    init(parent: EnhancedMapView) {
        self.parent = parent
    }
    
    // Custom pin views
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let weatherAnnotation = annotation as? WeatherAnnotation else {
            return nil
        }
        
        let identifier = "WeatherAnnotation"
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) ??
            MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        annotationView.annotation = annotation
        annotationView.canShowCallout = false
        
        // Custom SwiftUI annotation
        let customView = WeatherAnnotationView(
            weatherData: weatherAnnotation.weatherData,
            isSelected: parent.selectedLocation?.id == weatherAnnotation.weatherData.id
        )
        
        let hostingController = UIHostingController(rootView: customView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 80, height: 60)
        
        annotationView.subviews.forEach { $0.removeFromSuperview() } // Prevent duplicates
        annotationView.addSubview(hostingController.view)
        annotationView.frame = hostingController.view.frame
        
        return annotationView
    }
    
    // Handle tap on pin
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let weatherAnnotation = view.annotation as? WeatherAnnotation else { return }
        parent.onLocationSelected(weatherAnnotation.weatherData)
    }
    
    // Render weather overlay (OpenWeatherMap tiles)
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? WeatherTileOverlay {
            return WeatherTileRenderer(overlay: tileOverlay)
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
