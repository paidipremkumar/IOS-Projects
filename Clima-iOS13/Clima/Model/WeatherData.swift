//
//  WeatherData.swift
//  Clima
//
//  Created by prem on 14/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData: Decodable
{
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main:Decodable
{
    let temp: Double
}
struct Weather: Decodable
{
    let description: String
    let id: Int
}
