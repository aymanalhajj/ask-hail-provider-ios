//
//  FixedPagesModel.swift
//  AskHail
//
//  Created by bodaa on 27/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct FixedPagesModel : Codable {
    let status : Bool?
    let code : String?
    let data : FixedPagesData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(FixedPagesData.self, forKey: .data)
    }

}

struct FixedPagesData : Codable {
    let fixed_page_id : Int?
    let fixed_page_slug : String?
    let fixed_page_title : String?
    let fixed_page_body : String?

    enum CodingKeys: String, CodingKey {

        case fixed_page_id = "fixed_page_id"
        case fixed_page_slug = "fixed_page_slug"
        case fixed_page_title = "fixed_page_title"
        case fixed_page_body = "fixed_page_body"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fixed_page_id = try values.decodeIfPresent(Int.self, forKey: .fixed_page_id)
        fixed_page_slug = try values.decodeIfPresent(String.self, forKey: .fixed_page_slug)
        fixed_page_title = try values.decodeIfPresent(String.self, forKey: .fixed_page_title)
        fixed_page_body = try values.decodeIfPresent(String.self, forKey: .fixed_page_body)
    }

}
