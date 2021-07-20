
import Foundation

struct WeatherData2 : Codable {
    var daily: [Daily] = []
}

struct Daily : Codable {
    var temp : Temp = Temp()
    var feels_like: FeelsLike = FeelsLike()
    
}

struct Temp : Codable {
    var day: Double = 0.0
    var min: Double = 0.0
    var max: Double = 0.0
}

struct FeelsLike : Codable {
    var day: Double = 0.0
    var night: Double = 0.0
    
}
