import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = PersistanceWeather.shared.CityName
        
        self.weatherLabel.text =  PersistanceWeather.shared.Description
        
        self.weatherImage.image = UIImage(named:  PersistanceWeather.shared.ImageIndex ?? "image-not-found")
        
        self.tempLabel.text = PersistanceWeather.shared.TempKey
        
        
        
        weatherLoad()
        
    }
    
    //Parsing for current weather
    
    func weatherLoad(){
        let session = URLSession.shared
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=55.76&lon=37.62&appid=783cc27fd546af551179dfb71dfa6865&units=metric")!
        let task = session.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async{
                guard error == nil else{
                    print("Error")
                    return
                }
                do {
                    let json = try JSONDecoder().decode(WeatherData.self, from: data!)
                   
                    self.weatherImage.image = UIImage(named: json.weather[0].icon)
                    
                    self.tempLabel.text = "\(json.main.temp)" + " °С"
                    
                    self.nameLabel.text = "\(json.name)"
                    
                    self.weatherLabel.text = "\(json.weather[0].main)"
                    
                    
                    PersistanceWeather.shared.CityName =  self.nameLabel.text
                    PersistanceWeather.shared.TempKey = self.tempLabel.text
                    PersistanceWeather.shared.Description =  "\(json.weather[0].main)"
                    PersistanceWeather.shared.ImageIndex = json.weather[0].icon
                    
                    
                }catch{
                    print("wrong url")
                }
            }
            
        }
        task.resume()
    }
}
