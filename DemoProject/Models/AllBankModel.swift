//
//  AllBankModel.swift
//  AskHail
//
//  Created by Abdullah on 26/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct AllBankModel : Codable {
    let status : Bool?
    let code : String?
    let data : [AllBankData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([AllBankData].self, forKey: .data)
    }

}

struct AllBankData : Codable {
    let bank_account_id : Int?
    let bank_account_name : String?
    let bank_account_logo : String?

    enum CodingKeys: String, CodingKey {

        case bank_account_id = "bank_account_id"
        case bank_account_name = "bank_account_name"
        case bank_account_logo = "bank_account_logo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bank_account_id = try values.decodeIfPresent(Int.self, forKey: .bank_account_id)
        bank_account_name = try values.decodeIfPresent(String.self, forKey: .bank_account_name)
        bank_account_logo = try values.decodeIfPresent(String.self, forKey: .bank_account_logo)
    }

}
