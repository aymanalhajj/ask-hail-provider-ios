//
//  AdvAvilableModel.swift
//  AskHailBusiness
//
//  Created by bodaa on 14/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
struct AdvAvilableModel : Codable {
    let status : Bool?
    let code : String?
    let data : [AdvAvilableData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([AdvAvilableData].self, forKey: .data)
    }

}


struct AdvAvilableData : Codable {
    let unavailable_duration_id : Int?
    let unavailable_duration_advertisement_id : Int?
    let unavailable_duration_start_date : String?
    let unavailable_duration_days : Int?
    let unavailable_duration_end_date : String?
    let unavailable_duration_available_after_days : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case unavailable_duration_id = "unavailable_duration_id"
        case unavailable_duration_advertisement_id = "unavailable_duration_advertisement_id"
        case unavailable_duration_start_date = "unavailable_duration_start_date"
        case unavailable_duration_days = "unavailable_duration_days"
        case unavailable_duration_end_date = "unavailable_duration_end_date"
        case unavailable_duration_available_after_days = "unavailable_duration_available_after_days"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        unavailable_duration_id = try values.decodeIfPresent(Int.self, forKey: .unavailable_duration_id)
        unavailable_duration_advertisement_id = try values.decodeIfPresent(Int.self, forKey: .unavailable_duration_advertisement_id)
        unavailable_duration_start_date = try values.decodeIfPresent(String.self, forKey: .unavailable_duration_start_date)
        unavailable_duration_days = try values.decodeIfPresent(Int.self, forKey: .unavailable_duration_days)
        unavailable_duration_end_date = try values.decodeIfPresent(String.self, forKey: .unavailable_duration_end_date)
        unavailable_duration_available_after_days = try values.decodeIfPresent(Int.self, forKey: .unavailable_duration_available_after_days)
    }
    
}
