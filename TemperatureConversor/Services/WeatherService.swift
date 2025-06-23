import Foundation

struct WeatherService {
    static func fetchTemperature(latitude: Double, longitude: Double) async throws -> Double {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Print the raw JSON for debugging
        if let jsonString = String(data: data, encoding: .utf8) {
            print("[WeatherService] Raw JSON response: \(jsonString)")
        }
        // Use the default decoder (no keyDecodingStrategy)
        let decoder = JSONDecoder()

        let decodedResponse = try decoder.decode(WeatherResponse.self, from: data)
        
        return decodedResponse.current.temperature_2m
    }
}