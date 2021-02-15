//
//  RateModel.swift
//  AskHailBusiness
//
//  Created by bodaa on 15/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
struct AddRateModel : Codable {
    let status : Bool?
    let code : String?
    let data : Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(Data.self, forKey: .data)
    }

}
