//
//  WeatherLocation.swift
//  weather-gift
//
//  Created by Timothy Chin on 3/15/22.
//

import Foundation

class WeatherLocation: Codable {
    
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    func getData() {
//        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=42.335525&lon=-71.168645&appid=40ed7d887d778cd3a7958897d80f4f20"
    
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("ERROR! Could not create a URL from \(urlString)")
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
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
        }
    
        task.resume()
        
    }
    
}
