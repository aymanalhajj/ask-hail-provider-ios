//
//  SidesModel.swift
//  AskHail
//
//  Created by bodaa on 27/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct SidesModel : Codable {
    let status : Bool?
    let code : String?
    let data : [SidesData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([SidesData].self, forKey: .data)
    }

}

struct SidesData : Codable {
    let side_id : Int?
    let side_name : String?

    enum CodingKeys: String, CodingKey {

        case side_id = "side_id"
        case side_name = "side_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        side_id = try values.decodeIfPresent(Int.self, forKey: .side_id)
        side_name = try values.decodeIfPresent(String.self, forKey: .side_name)
    }

}
