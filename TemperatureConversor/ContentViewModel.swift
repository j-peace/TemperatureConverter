import Foundation
import CoreLocation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var currentTemperature: Double?
    @Published var isTextHidden = false
    @Published var temperatureUnit: String = "C" // Default to Celsius
    @Published var units: [String] = []
    
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
        fetchUnits()
    }
    
    func onAppear() {
        print("[ViewModel] onAppear called")
        locationManager.checkLocationAuthorization()
        if units.isEmpty {
            fetchUnits()
        }
    }
    
    private func fetchUnits() {
        guard let url = URL(string: "https://api-crimson-river-7025.fly.dev/list_of_units") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let list = json["list_of_units"] as? [String] {
                    DispatchQueue.main.async {
                        self?.units = list.map { $0.uppercased() }
                    }
                }
            } catch {
                print("Failed to decode units: \(error)")
            }
        }
        task.resume()
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