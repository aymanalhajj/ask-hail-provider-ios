//
//  PrayTimeModel.swift
//  AskHailBusiness
//
//  Created by bodaa on 07/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation

struct PrayTimeModel : Codable {
    let code : Int?
    let status : String?
    let data : PrayTimeData?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(PrayTimeData.self, forKey: .data)
    }

}

struct PrayTimeData : Codable {
    let timings : Timings?
    let date : Datee?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case timings = "timings"
        case date = "date"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timings = try values.decodeIfPresent(Timings.self, forKey: .timings)
        date = try values.decodeIfPresent(Datee.self, forKey: .date)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}

struct Datee : Codable {
    let readable : String?
    let timestamp : String?
    let hijri : Hijri?
    let gregorian : Gregorian?

    enum CodingKeys: String, CodingKey {

        case readable = "readable"
        case timestamp = "timestamp"
        case hijri = "hijri"
        case gregorian = "gregorian"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        readable = try values.decodeIfPresent(String.self, forKey: .readable)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        hijri = try values.decodeIfPresent(Hijri.self, forKey: .hijri)
        gregorian = try values.decodeIfPresent(Gregorian.self, forKey: .gregorian)
    }

}

struct Designation : Codable {
    let abbreviated : String?
    let expanded : String?

    enum CodingKeys: String, CodingKey {

        case abbreviated = "abbreviated"
        case expanded = "expanded"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        abbreviated = try values.decodeIfPresent(String.self, forKey: .abbreviated)
        expanded = try values.decodeIfPresent(String.self, forKey: .expanded)
    }

}

struct Gregorian : Codable {
    let date : String?
    let format : String?
    let day : String?
    let weekday : Weekday?
    let month : Month?
    let year : String?
    let designation : Designation?

    enum CodingKeys: String, CodingKey {

        case date = "date"
        case format = "format"
        case day = "day"
        case weekday = "weekday"
        case month = "month"
        case year = "year"
        case designation = "designation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        weekday = try values.decodeIfPresent(Weekday.self, forKey: .weekday)
        month = try values.decodeIfPresent(Month.self, forKey: .month)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        designation = try values.decodeIfPresent(Designation.self, forKey: .designation)
    }

}

struct Hijri : Codable {
    let date : String?
    let format : String?
    let day : String?
    let weekday : Weekday?
    let month : Month?
    let year : String?
    let designation : Designation?
    let holidays : [String]?

    enum CodingKeys: String, CodingKey {

        case date = "date"
        case format = "format"
        case day = "day"
        case weekday = "weekday"
        case month = "month"
        case year = "year"
        case designation = "designation"
        case holidays = "holidays"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        weekday = try values.decodeIfPresent(Weekday.self, forKey: .weekday)
        month = try values.decodeIfPresent(Month.self, forKey: .month)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        designation = try values.decodeIfPresent(Designation.self, forKey: .designation)
        holidays = try values.decodeIfPresent([String].self, forKey: .holidays)
    }

}

struct Meta : Codable {
    let latitude : Double?
    let longitude : Double?
    let timezone : String?
    let method : Methood?
    let latitudeAdjustmentMethod : String?
    let midnightMode : String?
    let school : String?
    let offset : Offset?

    enum CodingKeys: String, CodingKey {

        case latitude = "latitude"
        case longitude = "longitude"
        case timezone = "timezone"
        case method = "method"
        case latitudeAdjustmentMethod = "latitudeAdjustmentMethod"
        case midnightMode = "midnightMode"
        case school = "school"
        case offset = "offset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        method = try values.decodeIfPresent(Methood.self, forKey: .method)
        latitudeAdjustmentMethod = try values.decodeIfPresent(String.self, forKey: .latitudeAdjustmentMethod)
        midnightMode = try values.decodeIfPresent(String.self, forKey: .midnightMode)
        school = try values.decodeIfPresent(String.self, forKey: .school)
        offset = try values.decodeIfPresent(Offset.self, forKey: .offset)
    }

}

struct Methood : Codable {
    let id : Int?
    let name : String?
    let params : Params?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case params = "params"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        params = try values.decodeIfPresent(Params.self, forKey: .params)
    }

}

struct Offset : Codable {
    let imsak : Int?
    let fajr : Int?
    let sunrise : Int?
    let dhuhr : Int?
    let asr : Int?
    let maghrib : Int?
    let sunset : Int?
    let isha : Int?
    let midnight : Int?

    enum CodingKeys: String, CodingKey {

        case imsak = "Imsak"
        case fajr = "Fajr"
        case sunrise = "Sunrise"
        case dhuhr = "Dhuhr"
        case asr = "Asr"
        case maghrib = "Maghrib"
        case sunset = "Sunset"
        case isha = "Isha"
        case midnight = "Midnight"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imsak = try values.decodeIfPresent(Int.self, forKey: .imsak)
        fajr = try values.decodeIfPresent(Int.self, forKey: .fajr)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        dhuhr = try values.decodeIfPresent(Int.self, forKey: .dhuhr)
        asr = try values.decodeIfPresent(Int.self, forKey: .asr)
        maghrib = try values.decodeIfPresent(Int.self, forKey: .maghrib)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
        isha = try values.decodeIfPresent(Int.self, forKey: .isha)
        midnight = try values.decodeIfPresent(Int.self, forKey: .midnight)
    }

}

struct Params : Codable {
    let fajr : Double?
    let isha : String?

    enum CodingKeys: String, CodingKey {

        case fajr = "Fajr"
        case isha = "Isha"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fajr = try values.decodeIfPresent(Double.self, forKey: .fajr)
        isha = try values.decodeIfPresent(String.self, forKey: .isha)
    }

}

struct Timings : Codable {
    let fajr : String?
    let sunrise : String?
    let dhuhr : String?
    let asr : String?
    let sunset : String?
    let maghrib : String?
    let isha : String?
    let imsak : String?
    let midnight : String?

    enum CodingKeys: String, CodingKey {

        case fajr = "Fajr"
        case sunrise = "Sunrise"
        case dhuhr = "Dhuhr"
        case asr = "Asr"
        case sunset = "Sunset"
        case maghrib = "Maghrib"
        case isha = "Isha"
        case imsak = "Imsak"
        case midnight = "Midnight"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fajr = try values.decodeIfPresent(String.self, forKey: .fajr)
        sunrise = try values.decodeIfPresent(String.self, forKey: .sunrise)
        dhuhr = try values.decodeIfPresent(String.self, forKey: .dhuhr)
        asr = try values.decodeIfPresent(String.self, forKey: .asr)
        sunset = try values.decodeIfPresent(String.self, forKey: .sunset)
        maghrib = try values.decodeIfPresent(String.self, forKey: .maghrib)
        isha = try values.decodeIfPresent(String.self, forKey: .isha)
        imsak = try values.decodeIfPresent(String.self, forKey: .imsak)
        midnight = try values.decodeIfPresent(String.self, forKey: .midnight)
    }

}

struct Weekday : Codable {
    let en : String?

    enum CodingKeys: String, CodingKey {

        case en = "en"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        en = try values.decodeIfPresent(String.self, forKey: .en)
    }

}

struct Month : Codable {
    let number : Int?
    let en : String?
    let ar : String?
    

    enum CodingKeys: String, CodingKey {

        case number = "number"
        case en = "en"
        case ar = "ar"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        en = try values.decodeIfPresent(String.self, forKey: .en)
        ar = try values.decodeIfPresent(String.self, forKey: .ar)
    }

}
