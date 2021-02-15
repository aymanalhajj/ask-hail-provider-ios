//
//  ServicesModel.swift
//  AskHail
//
//  Created by Abdullah on 29/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct ServicesModel : Codable {
    let status : Bool?
    let code : String?
    let data : [ServicesData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([ServicesData].self, forKey: .data)
    }

}

struct ServicesData : Codable {
    let service_id : Int?
    let service_type : String?
    let service_title : String?
    let service_file : String?
    let service_custom_added_date : String?
    let service_added_date : String?

    enum CodingKeys: String, CodingKey {

        case service_id = "service_id"
        case service_type = "service_type"
        case service_title = "service_title"
        case service_file = "service_file"
        case service_custom_added_date = "service_custom_added_date"
        case service_added_date = "service_added_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        service_id = try values.decodeIfPresent(Int.self, forKey: .service_id)
        service_type = try values.decodeIfPresent(String.self, forKey: .service_type)
        service_title = try values.decodeIfPresent(String.self, forKey: .service_title)
        service_file = try values.decodeIfPresent(String.self, forKey: .service_file)
        service_custom_added_date = try values.decodeIfPresent(String.self, forKey: .service_custom_added_date)
        service_added_date = try values.decodeIfPresent(String.self, forKey: .service_added_date)
    }

}
