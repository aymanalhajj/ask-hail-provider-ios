//
//  AdvEditSectionModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 09/12/2020.
//  Copyright © 2020 Abdullah Tarek. All rights reserved.
//

import Foundation
struct AdvEditSectionModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditSectionData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditSectionData.self, forKey: .data)
    }

}

struct EditSectionData : Codable {
    let adv_id : Int?
    let adv_main_section_id : Int?
    let adv_sub_section_id : Int?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_main_section_id = "adv_main_section_id"
        case adv_sub_section_id = "adv_sub_section_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_main_section_id = try values.decodeIfPresent(Int.self, forKey: .adv_main_section_id)
        adv_sub_section_id = try values.decodeIfPresent(Int.self, forKey: .adv_sub_section_id)
    }

}

struct SuccessEditSectionModel : Codable {
    let status : Bool?
    let code : String?
    let data : SuccessEditSectionData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(SuccessEditSectionData.self, forKey: .data)
    }

}

struct SuccessEditSectionData : Codable {
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

