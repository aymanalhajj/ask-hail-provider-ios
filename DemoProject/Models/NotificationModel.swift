//
//  NotificationModel.swift
//  AskHail
//
//  Created by bodaa on 15/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct NotificationModel : Codable {
    let status : Bool?
    let code : String?
    let data : [NotificationData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([NotificationData].self, forKey: .data)
    }

}

struct NotificationData : Codable {
    let notify_id : String?
    let notify_text : String?
    let notify_type : String?
    let notify_type_id : Int?
    let notify_type_title : String?
    let notify_reading : Bool?
    let notify_custom_date : String?
    let notify_created_at : String?
    let notify_updated_at : String?
    let notify_advertiser_id : Int?

    enum CodingKeys: String, CodingKey {

        case notify_id = "notify_id"
        case notify_text = "notify_text"
        case notify_type = "notify_type"
        case notify_type_id = "notify_type_id"
        case notify_type_title = "notify_type_title"
        case notify_reading = "notify_reading"
        case notify_custom_date = "notify_custom_date"
        case notify_created_at = "notify_created_at"
        case notify_updated_at = "notify_updated_at"
        case notify_advertiser_id = "notify_advertiser_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notify_id = try values.decodeIfPresent(String.self, forKey: .notify_id)
        notify_text = try values.decodeIfPresent(String.self, forKey: .notify_text)
        notify_type = try values.decodeIfPresent(String.self, forKey: .notify_type)
        notify_type_id = try values.decodeIfPresent(Int.self, forKey: .notify_type_id)
        notify_type_title = try values.decodeIfPresent(String.self, forKey: .notify_type_title)
        notify_reading = try values.decodeIfPresent(Bool.self, forKey: .notify_reading)
        notify_custom_date = try values.decodeIfPresent(String.self, forKey: .notify_custom_date)
        notify_created_at = try values.decodeIfPresent(String.self, forKey: .notify_created_at)
        notify_updated_at = try values.decodeIfPresent(String.self, forKey: .notify_updated_at)
        notify_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .notify_advertiser_id)
    }

}
