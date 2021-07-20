

import Foundation
import Realm
import RealmSwift


class RealmWeatherData: Object{
    dynamic var realmDaily = List<RealmDaily>()
}
class RealmDaily: Object{
    @objc dynamic var Realmtemp : RealmTemp? = RealmTemp()
    @objc dynamic var RealmFeels_like: RealmFeelsLike? = RealmFeelsLike()
}

class RealmTemp : Object {
    @objc dynamic var RealmDay: Double = 0.0
    @objc dynamic var RealmMin: Double = 0.0
    @objc dynamic var RealmMax: Double = 0.0
}
class RealmFeelsLike : Object {
    @objc dynamic var Realmday: Double = 0.0
    @objc dynamic var Realmnight: Double = 0.0
}


