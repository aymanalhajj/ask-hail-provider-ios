//
//  EditeAdvertismentModel\.swift
//  AskHail
//
//  Created by bodaa on 23/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import Foundation
struct EditimagesModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditimagesData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditimagesData.self, forKey: .data)
    }

}
struct EditimagesData : Codable {
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
