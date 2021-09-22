//
//  WeatherManager.swift
//  Clima
//
//  Created by prem on 14/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,weather:WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager
{
    let webUrl = "https://api.openweathermap.org/data/2.5/weather?appid=dc89cdc6d5ea157b91fca52ed1c785a1"
    var delegate: WeatherManagerDelegate?
    func getWeather(cityName:String)
    {
        let weatherString = "\(webUrl)&q=\(cityName)&units=metric"
        performTasks(weatherString)
    }
    func getWeather(latitude : CLLocationDegrees , longitude : CLLocationDegrees)
    {
        let weatherUrl = "\(webUrl)&units=metric&lat=\(latitude)&lon=\(longitude)"
        performTasks(weatherUrl)
    }
    func performTasks(_ urlString:String)
    {
        if let url = URL(string: urlString)
        {
            let session = URLSession(configuration: .default)
            // the next line uses closure
            let task = session.dataTask(with: url) { data, URLResponse, error in
                if error != nil
                {
                    self.delegate?.didFailWithError(error: error!)
                    return //exit the entire loop
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData)
                    {
                        self.delegate?.didUpdateWeather(self , weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?
    {
        let decoder = JSONDecoder()
        do
        {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //print(decodedData.main.temp)
            // print(decodedData.weather[0].description)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionID: id, cityName:name, temperature: temp)
            return weather
        }
        catch
        {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
