//
//  RegisterModel_2.swift
//  AskHail
//
//  Created by Abdullah Tarek on 26/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct RegisterModel_2 : Codable {
    let status : Bool?
    let code : String?
    let data : RegisterData_2?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(RegisterData_2.self, forKey: .data)
    }

}

struct RegisterData_2 : Codable {
    let advertiser_id : Int?
    let next_level : Int?

    enum CodingKeys: String, CodingKey {

        case advertiser_id = "advertiser_id"
        case next_level = "next_level"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertiser_id = try values.decodeIfPresent(Int.self, forKey: .advertiser_id)
        next_level = try values.decodeIfPresent(Int.self, forKey: .next_level)
    }

}

