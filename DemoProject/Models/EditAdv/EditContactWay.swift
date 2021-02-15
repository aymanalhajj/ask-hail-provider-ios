//
//  EditContactWay.swift
//  AskHail
//
//  Created by Abdullah Tarek on 13/12/2020.
//

import Foundation
struct EditContactWayModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditContactWayData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditContactWayData.self, forKey: .data)
    }

}

struct EditContactWayData : Codable {
    let adv_id : Int?
    let adv_call_number_status : String?
    let adv_call_number : String?
    let adv_whatsapp_number_status : String?
    let adv_whatsapp_number : String?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_call_number_status = "adv_call_number_status"
        case adv_call_number = "adv_call_number"
        case adv_whatsapp_number_status = "adv_whatsapp_number_status"
        case adv_whatsapp_number = "adv_whatsapp_number"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_call_number_status = try values.decodeIfPresent(String.self, forKey: .adv_call_number_status)
        adv_call_number = try values.decodeIfPresent(String.self, forKey: .adv_call_number)
        adv_whatsapp_number_status = try values.decodeIfPresent(String.self, forKey: .adv_whatsapp_number_status)
        adv_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .adv_whatsapp_number)
    }

}

