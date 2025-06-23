import Foundation
import CoreLocation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var currentTemperature: Double? // Celsius from OpenMeteo
    @Published var currentConvertedTemperature: Double? // Converted value for display
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
            self.lastKnownLocation = location
            if let location = location {
                self.fetchTemperature(for: location)
            }
        }
        fetchUnits()
    }
    
    func onAppear() {
        locationManager.checkLocationAuthorization()
        if units.isEmpty {
            fetchUnits()
        }
        // Fetch conversion if we already have a temperature
        if let temp = currentTemperature {
            fetchConvertedTemperature(targetUnit: temperatureUnit, temperatureInCelsius: temp)
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
            } catch {}
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
        Task { [weak self] in
            do {
                let temp = try await WeatherService.fetchTemperature(latitude: coordinate.latitude, longitude: coordinate.longitude)
                await MainActor.run {
                    self?.currentTemperature = temp
                    self?.fetchConvertedTemperature(targetUnit: self?.temperatureUnit ?? "C", temperatureInCelsius: temp)
                }
            } catch {}
        }
    }
    
    func selectUnit(_ unit: String) {
        let normalized = unit.uppercased()
        temperatureUnit = normalized
        if let temp = currentTemperature {
            fetchConvertedTemperature(targetUnit: normalized, temperatureInCelsius: temp)
        }
    }
    
    private func fetchConvertedTemperature(targetUnit: String, temperatureInCelsius: Double) {
        // Always show loading
        DispatchQueue.main.async {
            self.currentConvertedTemperature = nil
        }
        // If unit is C, just show the original value
        if targetUnit.uppercased() == "C" {
            DispatchQueue.main.async {
                self.currentConvertedTemperature = temperatureInCelsius
            }
            return
        }
        let apiUnit = targetUnit.uppercased()
        guard let url = URL(string: "https://api-crimson-river-7025.fly.dev/conversion?targetUnit=\(apiUnit)&temperatureInCelsius=\(temperatureInCelsius)") else {
            DispatchQueue.main.async {
                self.currentConvertedTemperature = temperatureInCelsius
            }
            return
        }
        print("[Conversion] Payload: \(url)")
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.currentConvertedTemperature = temperatureInCelsius
                }
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print("[Conversion] Response: \(jsonString)")
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let value = json["converted_temp"] as? Double {
                    DispatchQueue.main.async {
                        self.currentConvertedTemperature = value
                    }
                } else {
                    DispatchQueue.main.async {
                        self.currentConvertedTemperature = temperatureInCelsius
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.currentConvertedTemperature = temperatureInCelsius
                }
            }
        }
        task.resume()
    }
} 
