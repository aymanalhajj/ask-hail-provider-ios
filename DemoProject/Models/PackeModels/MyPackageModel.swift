//
//  MyPackageModel.swift
//  AskHail
//
//  Created by bodaa on 12/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct MyPackageModel : Codable {
    let status : Bool?
    let code : String?
    let data : MyPackageData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(MyPackageData.self, forKey: .data)
    }

}

struct MyPackageData : Codable {
    let package_id : Int?
    let package_name : String?
    let package_description : String?
    let package_rate : String?
    let package_duration_in_days : String?
    let package_price : String?
    let package_advertisements_count : String?
    let package_details : Package_details?
    let package_if_subscription_type_is_later : Bool?

    enum CodingKeys: String, CodingKey {

        case package_id = "package_id"
        case package_name = "package_name"
        case package_description = "package_description"
        case package_rate = "package_rate"
        case package_duration_in_days = "package_duration_in_days"
        case package_price = "package_price"
        case package_advertisements_count = "package_advertisements_count"
        case package_details = "package_details"
        case package_if_subscription_type_is_later = "package_if_subscription_type_is_later"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        package_id = try values.decodeIfPresent(Int.self, forKey: .package_id)
        package_name = try values.decodeIfPresent(String.self, forKey: .package_name)
        package_description = try values.decodeIfPresent(String.self, forKey: .package_description)
        package_rate = try values.decodeIfPresent(String.self, forKey: .package_rate)
        package_duration_in_days = try values.decodeIfPresent(String.self, forKey: .package_duration_in_days)
        package_price = try values.decodeIfPresent(String.self, forKey: .package_price)
        package_advertisements_count = try values.decodeIfPresent(String.self, forKey: .package_advertisements_count)
        package_details = try values.decodeIfPresent(Package_details.self, forKey: .package_details)
        package_if_subscription_type_is_later = try values.decodeIfPresent(Bool.self, forKey: .package_if_subscription_type_is_later)
    }

}

struct Package_details : Codable {
    let subscription_start_date : String?
    let subscription_custom_start_date : String?
    let subscription_end_date : String?
    let subscription_custom_end_date : String?
    let subscription_used_advertisements : Int?
    let subscription_rest_days : Int?
    let subscription_can_renew_package_status : Bool?

    enum CodingKeys: String, CodingKey {

        case subscription_start_date = "subscription_start_date"
        case subscription_custom_start_date = "subscription_custom_start_date"
        case subscription_end_date = "subscription_end_date"
        case subscription_custom_end_date = "subscription_custom_end_date"
        case subscription_used_advertisements = "subscription_used_advertisements"
        case subscription_rest_days = "subscription_rest_days"
        case subscription_can_renew_package_status = "subscription_can_renew_package_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subscription_start_date = try values.decodeIfPresent(String.self, forKey: .subscription_start_date)
        subscription_custom_start_date = try values.decodeIfPresent(String.self, forKey: .subscription_custom_start_date)
        subscription_end_date = try values.decodeIfPresent(String.self, forKey: .subscription_end_date)
        subscription_custom_end_date = try values.decodeIfPresent(String.self, forKey: .subscription_custom_end_date)
        subscription_used_advertisements = try values.decodeIfPresent(Int.self, forKey: .subscription_used_advertisements)
        subscription_rest_days = try values.decodeIfPresent(Int.self, forKey: .subscription_rest_days)
        subscription_can_renew_package_status = try values.decodeIfPresent(Bool.self, forKey: .subscription_can_renew_package_status)
    }

}
