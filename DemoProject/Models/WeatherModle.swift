//
//  WeatherModle.swift
//  AskHailBusiness
//
//  Created by bodaa on 05/02/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

struct weatherModel {
    var dt : Int?
    var sunrise : Int?
    var sunset : Int?
    var temp : Temp?
    var feels_like : Feels_like?
    var pressure : Int?
    var humidity : Int?
    var dew_point : Double?
    var wind_speed : Double?
    var wind_deg : Int?
    var weather : Array<Weather>?
    var clouds : Int?
    var pop : Int?
    var uvi : Double?
    
}
struct Temp {
    var day : Double?
    var min : Double?
    var max : Double?
    var night : Double?
    var eve : Double?
    var morn : Double?
    
    
    
    
}
struct Weather {
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
    
    
    
}
struct Feels_like {
    var day : Double?
    var night : Double?
    var eve : Double?
    var morn : Double?
    
    
    
}
