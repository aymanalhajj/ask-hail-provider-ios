//
//  EditSettingModel.swift
//  AskHail
//
//  Created by bodaa on 12/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct EditSettingModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditSettingData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditSettingData.self, forKey: .data)
    }

}


struct EditSettingData : Codable {
    let advertiser_id : Int?
    let advertiser_all_notifications_status : String?
    let advertiser_new_comments_status : String?
    let advertiser_chat_status : String?
    let advertiser_question_replies_status : String?
    let advertiser_favorite_status : String?
    let advertiser_language_used : String?

    enum CodingKeys: String, CodingKey {

        case advertiser_id = "advertiser_id"
        case advertiser_all_notifications_status = "advertiser_all_notifications_status"
        case advertiser_new_comments_status = "advertiser_new_comments_status"
        case advertiser_chat_status = "advertiser_chat_status"
        case advertiser_question_replies_status = "advertiser_question_replies_status"
        case advertiser_favorite_status = "advertiser_favorite_status"
        case advertiser_language_used = "advertiser_language_used"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertiser_id = try values.decodeIfPresent(Int.self, forKey: .advertiser_id)
        advertiser_all_notifications_status = try values.decodeIfPresent(String.self, forKey: .advertiser_all_notifications_status)
        advertiser_new_comments_status = try values.decodeIfPresent(String.self, forKey: .advertiser_new_comments_status)
        advertiser_chat_status = try values.decodeIfPresent(String.self, forKey: .advertiser_chat_status)
        advertiser_question_replies_status = try values.decodeIfPresent(String.self, forKey: .advertiser_question_replies_status)
        advertiser_favorite_status = try values.decodeIfPresent(String.self, forKey: .advertiser_favorite_status)
        advertiser_language_used = try values.decodeIfPresent(String.self, forKey: .advertiser_language_used)
    }

}
