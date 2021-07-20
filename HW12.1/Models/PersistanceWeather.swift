//
//  PersistanceWeather.swift
//  HW12.1
//
//  Created by Григорий Душин on 29.06.2021.
//


import Foundation

class PersistanceWeather{
    static let shared = PersistanceWeather()
    private let kCityNameKey = "PersistanceWeather.kUserNameKey"
    private let kTempKey = "Persistance.kTempKey"
    private let kDescription = "Persistance.kDescription"
    private let kImageIndex = "Persistance.kImageIndex"
    
    var CityName: String?{
        set{UserDefaults.standard.set(newValue, forKey: kCityNameKey)}
        get{return UserDefaults.standard.string(forKey: kCityNameKey)}
        
    }
    
    var TempKey: String?{
        set{UserDefaults.standard.set(newValue, forKey: kTempKey)}
        get{return UserDefaults.standard.string(forKey: kTempKey)}
        
    }
    
    var Description: String?{
        set{UserDefaults.standard.set(newValue, forKey: kDescription)}
        get{return UserDefaults.standard.string(forKey: kDescription)}
        
    }
    var ImageIndex: String?{
        set{UserDefaults.standard.set(newValue, forKey: kImageIndex)}
        get{return UserDefaults.standard.string(forKey: kImageIndex)}
        
    }
    
    
}
