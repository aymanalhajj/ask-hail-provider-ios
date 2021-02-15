//
//  Success.swift
//  AskHail
//
//  Created by bodaa on 13/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct SuccessEditContactModel : Codable {
    let status : Bool?
    let code : String?
    let data : SuccessEditContactData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(SuccessEditContactData.self, forKey: .data)
    }

}

struct SuccessEditContactData : Codable {
    let message : String?
    let advertisement_id : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case advertisement_id = "advertisement_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        advertisement_id = try values.decodeIfPresent(Int.self, forKey: .advertisement_id)
    }

}
