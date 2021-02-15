//
//  SpecialModel.swift
//  AskHail
//
//  Created by bodaa on 24/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation

import Foundation
struct SpecialModel : Codable {
    let status : Bool?
    let code : String?
    let data : SpecialData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(SpecialData.self, forKey: .data)
    }

}


struct SpecialData : Codable {
    let special_image : String?
    let special_description : String?
    let special_advantages : [String]?

    enum CodingKeys: String, CodingKey {

        case special_image = "special_image"
        case special_description = "special_description"
        case special_advantages = "special_advantages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        special_image = try values.decodeIfPresent(String.self, forKey: .special_image)
        special_description = try values.decodeIfPresent(String.self, forKey: .special_description)
        special_advantages = try values.decodeIfPresent([String].self, forKey: .special_advantages)
    }

}
