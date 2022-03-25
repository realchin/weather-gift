//
//  WeatherDetail.swift
//  weather-gift
//
//  Created by Timothy Chin on 3/25/22.
//

import Foundation

class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        
        var timezone: String
        var current: Current
        
    }
    
    struct Current: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    
    struct Weather: Codable {
        var description: String
        var icon: String
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping () -> ()) {
//        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=42.335525&lon=-71.168645&appid=40ed7d887d778cd3a7958897d80f4f20"
    
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("ERROR! Could not create a URL from \(urlString)")
            completed()
            return
        }
        
        // Create session
        
        let session = URLSession.shared
        
        // get data with .dataTask method
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            // note: there are some additional things that could go wrong when using URLSession, but we shouldnt experience them, so we will ignore testing for these for now...
            
            // deal with the data
            
            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dailyIcon = result.current.weather[0].icon
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
            completed()
        }
    
        task.resume()
        
    }
    
}
