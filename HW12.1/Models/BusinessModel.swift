
import Foundation
import Realm
import RealmSwift

struct BusinessWeatherData  {
    var businessDaily: [BusinessDaily] = []
}

struct BusinessDaily  {
    var businessTemp : Temp = Temp()
    var businessFeels_like: FeelsLike = FeelsLike()
    
}

struct BusinessTemp  {
    var day: Double = 0.0
}

struct BusinessFeelsLike  {
    var day: Double = 0.0
}
















