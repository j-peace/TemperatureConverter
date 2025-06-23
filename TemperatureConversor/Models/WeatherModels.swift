import Foundation

// MARK: - Weather API Structs
struct WeatherResponse: Codable {
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature_2m: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature_2m = "temperature_2m"
    }
} 