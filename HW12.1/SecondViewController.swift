
import UIKit
import RealmSwift
import Realm

class SecondViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var jokeImageView: UIImageView!
    
    var weatherData = WeatherData2()
    
    var realmWeatherData = RealmWeatherData()
    
    var businessWeatherData = BusinessWeatherData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadWeather{(weatherData) in
            self.weatherData = weatherData
            
            DispatchQueue.main.async {
                self.TableView.reloadData()
                
            }
        }
        
    }
    
    //FORECAST PARSING (NEXT 7 DAYS)
    
    
    func loadWeather(completition: @escaping (WeatherData2)->Void){
        let session = URLSession.shared
        
        let url2 = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.76&lon=37.62&exclude=current,minutely,hourly,alerts&appid=783cc27fd546af551179dfb71dfa6865&units=metric")!
        let task = session.dataTask(with: url2) { (data, responce, error) in
            DispatchQueue.main.async
            {
                [self] in
                guard error == nil else{
                    
                    print("No connection")
                    
                    let realm = try!Realm()
                    
                    self.realmWeatherData = realm.objects(RealmWeatherData.self).last!
                    
                    // CONVERTING INTO BUSINESS MODEL
                    
                   
                    self.businessWeatherData = self.mapBusiness2(model: self.realmWeatherData)
                    
                    return
                }
                
                do {
                    
                    self.weatherData = try JSONDecoder().decode(WeatherData2.self, from: data!)
                    
                    // SAVING IN REALM
                    
                    self.realmWeatherData = self.mapWeatherData2( model: self.weatherData )
                    
                    let realm = try! Realm()
                    realm.beginWrite()
                    realm.add(self.realmWeatherData)
                    try! realm.commitWrite()
                    
                    // CONVERTING INTO BUSINESS MODEL
                    
                    self.businessWeatherData = self.mapBusiness(model: self.weatherData)
                    
                }catch{
                    print("wrong url")
                }
            }
            
            completition(self.weatherData)
            
        }
        task.resume()
        
        
        
    }
    
    
    //REALM FUNC
    
    func mapWeatherData2(model: WeatherData2) -> RealmWeatherData {
        let modelRealm = RealmWeatherData()
        
        for el in model.daily {
            modelRealm.realmDaily.append(mapDaily(model: el))
        }
        return modelRealm
    }
    
    func mapDaily(model:Daily) -> RealmDaily{
        let modelDaily = RealmDaily()
        
        modelDaily.RealmFeels_like?.Realmday = model.feels_like.day
        modelDaily.RealmFeels_like?.Realmnight = model.feels_like.night
        
        modelDaily.Realmtemp?.RealmDay = model.temp.day
        modelDaily.Realmtemp?.RealmMax = model.temp.max
        modelDaily.Realmtemp?.RealmMin = model.temp.min
        
        return modelDaily
    }
    
    func mapTemp(model:Temp) -> RealmTemp{
        let modelTemp = RealmTemp()
        
        modelTemp.RealmDay = model.day
        modelTemp.RealmMin = model.min
        modelTemp.RealmMax = model.max
        
        return modelTemp
    }
    
    
    func mapFeelsLike(model:FeelsLike) -> RealmFeelsLike{
        let modelFeelsLike = RealmFeelsLike()
        
        modelFeelsLike.Realmday = model.day
        modelFeelsLike.Realmnight = model.night
        
        
        return modelFeelsLike
        
    }
    
    //ФУНКЦИИ ДЛЯ БИЗНЕС МОДЕЛИ (парсинг -> бизнес модель)
    
    func mapBusiness(model: WeatherData2) -> BusinessWeatherData {
        
        var businessModel = BusinessWeatherData()
        
        
        for el in model.daily {
            
            businessModel.businessDaily.append(mapDailyBusiness(model: el))
            
        }
        return businessModel
    }
    
    
    
    func mapDailyBusiness(model:Daily) -> BusinessDaily{
        var modelDaily = BusinessDaily()
        
        modelDaily.businessFeels_like.day = model.feels_like.day
        
        modelDaily.businessTemp.day = model.temp.day
        
        return modelDaily
    }
    
    
    
    func mapTempBusiness(model:Temp) -> BusinessTemp{
        
        var modelTemp = BusinessTemp()
        
        modelTemp.day = model.day
        
        return modelTemp
    }
    
    
    func mapFeelsLikeBusiness(model:FeelsLike) -> BusinessFeelsLike{
        
        var modelFeelsLike = BusinessFeelsLike()
        
        modelFeelsLike.day = model.day
        
        
        
        return modelFeelsLike
        
    }
    
    
    
    //ФУНКЦИИ ДЛЯ БИЗНЕС МОДЕЛИ (реалм -> бизнес модель)
    
    
    func mapBusiness2(model: RealmWeatherData) -> BusinessWeatherData {
        var businessModel2 = BusinessWeatherData()
        
        for el in model.realmDaily {
            
            businessModel2.businessDaily.append(mapDailyBusiness2(model: el))
            
            
            
        }
        return businessModel2
    }
    
    
    
    func mapDailyBusiness2(model:RealmDaily) -> BusinessDaily{
        var modelDaily = BusinessDaily()
        
        modelDaily.businessFeels_like.day = model.RealmFeels_like!.Realmday
        
        modelDaily.businessTemp.day = model.Realmtemp!.RealmDay
        
        return modelDaily
    }
    
    
    
    func mapTempBusiness2(model:RealmTemp) -> BusinessTemp{
        
        var modelTemp = BusinessTemp()
        
        modelTemp.day = model.RealmDay
        
        return modelTemp
    }
    
    
    func mapFeelsLikeBusiness2(model:RealmFeelsLike) -> BusinessFeelsLike{
        
        var modelFeelsLike = BusinessFeelsLike()
        
        modelFeelsLike.day = model.Realmday
        
        return modelFeelsLike
        
    }
}

extension SecondViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print (businessWeatherData.businessDaily.count)
        
        return self.businessWeatherData.businessDaily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OurCell", for: indexPath) as! TableViewCell
        
        
        
        let catBusiness = self.businessWeatherData.businessDaily[indexPath.row].businessTemp.day
        
        let catBusiness2 = self.businessWeatherData.businessDaily[indexPath.row].businessFeels_like.day
        
        
        cell.Label1.text = "\(catBusiness)" + " °С"
        cell.FeelsLike.text = "\(catBusiness2)" + " °С"
        
        if indexPath.row == 0
        {
            cell.Label2.text = "Today"
        }else{
            cell.Label2.text = "\(indexPath.row )"
        }
        
        return cell
        
    }
    
    
}

