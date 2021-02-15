//
//  SpecialPackageModel.swift
//  AskHail
//
//  Created by bodaa on 12/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
struct SpecialPackageModel : Codable {
    let status : Bool?
    let code : String?
    let data : [SpecialPackageData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([SpecialPackageData].self, forKey: .data)
    }

}

struct SpecialPackageData : Codable {
    let package_id : Int?
    let package_name : String?
    let package_description : String?
    let package_rate : String?
    let package_duration_in_days : String?
    let package_price : String?

    enum CodingKeys: String, CodingKey {

        case package_id = "package_id"
        case package_name = "package_name"
        case package_description = "package_description"
        case package_rate = "package_rate"
        case package_duration_in_days = "package_duration_in_days"
        case package_price = "package_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        package_id = try values.decodeIfPresent(Int.self, forKey: .package_id)
        package_name = try values.decodeIfPresent(String.self, forKey: .package_name)
        package_description = try values.decodeIfPresent(String.self, forKey: .package_description)
        package_rate = try values.decodeIfPresent(String.self, forKey: .package_rate)
        package_duration_in_days = try values.decodeIfPresent(String.self, forKey: .package_duration_in_days)
        package_price = try values.decodeIfPresent(String.self, forKey: .package_price)
    }

}
