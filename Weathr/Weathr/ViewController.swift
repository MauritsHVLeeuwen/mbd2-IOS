//
//  ViewController.swift
//  Weathr
//
//  Created by Maurits van Leeuwen on 28/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Location: UILabel!
    
    @IBOutlet weak var Temperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Location.text = "Den Bosch"
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=s-Hertogenbosch&appid=3b7c0bb2df5778f696d6dfc53b6189c9") {
            let task = URLSession.shared.dataTask(with: url) {data, response, error in
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data!) as?[String:Any] {
//                        if let main = json["main"] as? [String:Any], var temperature = main["temp"] as? Double {
//                            DispatchQueue.main.async {
//                                temperature = temperature - 273.15
//                                temperature = round(100*temperature)/100
//                                self.Temperature.text = "\(temperature)°"
//                            }
//                        }
//                    }
//                } catch {
//
//                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherData.self, from: data!)
                    DispatchQueue.main.async {
                        var temperature = weatherData.main.temp - 273.15
                        temperature = round(100*temperature)/100
                        self.Temperature.text = "\(temperature)°"
                    }
                } catch {
                    
                }
            }
            task.resume()
        }
    }


}

