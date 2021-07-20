
import Foundation

struct WeatherData: Codable {
    var weather: [Weather] = []
    var main: Main = Main()
    var name: String = ""
    
}

struct Weather: Codable{
    var main: String
    var icon: String
}

struct Main: Codable{
    var temp: Double = 0.0
}













