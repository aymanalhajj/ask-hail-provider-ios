//
//  BlocksModel.swift
//  AskHail
//
//  Created by bodaa on 27/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct BlocksModel : Codable {
    let status : Bool?
    let code : String?
    let data : [BlocksData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([BlocksData].self, forKey: .data)
    }

}

struct BlocksData : Codable {
    let block_id : Int?
    let block_name : String?

    enum CodingKeys: String, CodingKey {

        case block_id = "block_id"
        case block_name = "block_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block_id = try values.decodeIfPresent(Int.self, forKey: .block_id)
        block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
    }

}
