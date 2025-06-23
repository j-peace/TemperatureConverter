import Foundation
import CoreLocation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var currentTemperature: Double?
    @Published var isTextHidden = false
    @Published var temperatureUnit: String = "C" // Default to Celsius
    
    var temperatureUnitSymbol: String {
        return temperatureUnit
    }
    
    private let locationManager = LocationManager()
    private var locationCancellable: Any?
    
    init() {
        // Observe location updates
        locationManager.checkLocationAuthorization()
        locationCancellable = locationManager.$lastKnownLocation.sink { [weak self] location in
            guard let self = self else { return }
            print("[ViewModel] Location updated: \(String(describing: location))")
            self.lastKnownLocation = location
            if let location = location {
                self.fetchTemperature(for: location)
            }
        }
    }
    
    func onAppear() {
        print("[ViewModel] onAppear called")
        locationManager.checkLocationAuthorization()
    }
    
    func togglePreview() {
        isTextHidden.toggle()
        print("[ViewModel] isTextHidden toggled: \(isTextHidden)")
        if isTextHidden, let location = lastKnownLocation {
            fetchTemperature(for: location)
        }
    }
    
    private func fetchTemperature(for coordinate: CLLocationCoordinate2D) {
        print("[ViewModel] Fetching temperature for: \(coordinate)")
        Task { [weak self] in
            do {
                let temp = try await WeatherService.fetchTemperature(latitude: coordinate.latitude, longitude: coordinate.longitude)
                await MainActor.run {
                    print("[ViewModel] Temperature fetched: \(temp)")
                    self?.currentTemperature = temp
                }
            } catch {
                print("[ViewModel] Failed to fetch temperature: \(error)")
            }
        }
    }
} 