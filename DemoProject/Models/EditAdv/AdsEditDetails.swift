//
//  AdsEditDetails.swift
//  AskHail
//
//  Created by bodaa on 09/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct AdvEditDetailsModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditDetailsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditDetailsData.self, forKey: .data)
    }

}

struct EditDetailsData : Codable {
let adv_id : Int?
let adv_title : String?
let adv_description : String?
let adv_location : String?
let adv_latitude : String?
let adv_longitude : String?
let adv_price : String?
let adv_side_id : Int?
let adv_side : Adv_side?
let adv_region_id : Int?
let adv_region : Adv_region?
let adv_city_id : Int?
let adv_city : Adv_city?
let adv_block_id : Int?
let adv_block : Adv_block?
let adv_specifications : [Adv_specifications]?

enum CodingKeys: String, CodingKey {

    case adv_id = "adv_id"
    case adv_title = "adv_title"
    case adv_description = "adv_description"
    case adv_location = "adv_location"
    case adv_latitude = "adv_latitude"
    case adv_longitude = "adv_longitude"
    case adv_price = "adv_price"
    case adv_side_id = "adv_side_id"
    case adv_side = "adv_side"
    case adv_region_id = "adv_region_id"
    case adv_region = "adv_region"
    case adv_city_id = "adv_city_id"
    case adv_city = "adv_city"
    case adv_block_id = "adv_block_id"
    case adv_block = "adv_block"
    case adv_specifications = "adv_specifications"
}

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
    adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
    adv_description = try values.decodeIfPresent(String.self, forKey: .adv_description)
    adv_location = try values.decodeIfPresent(String.self, forKey: .adv_location)
    adv_latitude = try values.decodeIfPresent(String.self, forKey: .adv_latitude)
    adv_longitude = try values.decodeIfPresent(String.self, forKey: .adv_longitude)
    adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
    adv_side_id = try values.decodeIfPresent(Int.self, forKey: .adv_side_id)
    adv_side = try values.decodeIfPresent(Adv_side.self, forKey: .adv_side)
    adv_region_id = try values.decodeIfPresent(Int.self, forKey: .adv_region_id)
    adv_region = try values.decodeIfPresent(Adv_region.self, forKey: .adv_region)
    adv_city_id = try values.decodeIfPresent(Int.self, forKey: .adv_city_id)
    adv_city = try values.decodeIfPresent(Adv_city.self, forKey: .adv_city)
    adv_block_id = try values.decodeIfPresent(Int.self, forKey: .adv_block_id)
    adv_block = try values.decodeIfPresent(Adv_block.self, forKey: .adv_block)
    adv_specifications = try values.decodeIfPresent([Adv_specifications].self, forKey: .adv_specifications)
}

}

struct Adv_city : Codable {
    let city_id : Int?
    let city_region : City_region?
    let city_name : String?
    let admin_city_name : String?

    enum CodingKeys: String, CodingKey {

        case city_id = "city_id"
        case city_region = "city_region"
        case city_name = "city_name"
        case admin_city_name = "admin_city_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_id = try values.decodeIfPresent(Int.self, forKey: .city_id)
        city_region = try values.decodeIfPresent(City_region.self, forKey: .city_region)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        admin_city_name = try values.decodeIfPresent(String.self, forKey: .admin_city_name)
    }

}


struct Adv_region : Codable {
    let region_id : Int?
    let region_name : String?

    enum CodingKeys: String, CodingKey {

        case region_id = "region_id"
        case region_name = "region_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        region_id = try values.decodeIfPresent(Int.self, forKey: .region_id)
        region_name = try values.decodeIfPresent(String.self, forKey: .region_name)
    }

}

struct Adv_side : Codable {
    let side_id : Int?
    let side_name : String?

    enum CodingKeys: String, CodingKey {

        case side_id = "side_id"
        case side_name = "side_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        side_id = try values.decodeIfPresent(Int.self, forKey: .side_id)
        side_name = try values.decodeIfPresent(String.self, forKey: .side_name)
    }

}


struct Adv_block : Codable {
    let block_id : String?
    let block_city : Block_city?
    let block_name : String?
    let admin_block_name : String?

    enum CodingKeys: String, CodingKey {

        case block_id = "block_id"
        case block_city = "block_city"
        case block_name = "block_name"
        case admin_block_name = "admin_block_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block_id = try values.decodeIfPresent(String.self, forKey: .block_id)
        block_city = try values.decodeIfPresent(Block_city.self, forKey: .block_city)
        block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
        admin_block_name = try values.decodeIfPresent(String.self, forKey: .admin_block_name)
    }

}


struct Adv_specifications : Codable {
    let specification_id : Int?
    let specification_adv_id : Int?
    let specification_section_feature : Specification_section_feature?
    let specification_answer : String?

    enum CodingKeys: String, CodingKey {

        case specification_id = "specification_id"
        case specification_adv_id = "specification_adv_id"
        case specification_section_feature = "specification_section_feature"
        case specification_answer = "specification_answer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specification_id = try values.decodeIfPresent(Int.self, forKey: .specification_id)
        specification_adv_id = try values.decodeIfPresent(Int.self, forKey: .specification_adv_id)
        specification_section_feature = try values.decodeIfPresent(Specification_section_feature.self, forKey: .specification_section_feature)
        specification_answer = try values.decodeIfPresent(String.self, forKey: .specification_answer)
    }
}
struct Specification_section_feature : Codable {
    let feature_id : Int?
    let feature_section : Feature_section?
    let feature_name : String?
    let feature_type : String?

    enum CodingKeys: String, CodingKey {

        case feature_id = "feature_id"
        case feature_section = "feature_section"
        case feature_name = "feature_name"
        case feature_type = "feature_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        feature_id = try values.decodeIfPresent(Int.self, forKey: .feature_id)
        feature_section = try values.decodeIfPresent(Feature_section.self, forKey: .feature_section)
        feature_name = try values.decodeIfPresent(String.self, forKey: .feature_name)
        feature_type = try values.decodeIfPresent(String.self, forKey: .feature_type)
    }

}
struct Feature_section : Codable {
    let section_id : Int?
    let section_name : String?
    let section_image : String?

    enum CodingKeys: String, CodingKey {

        case section_id = "section_id"
        case section_name = "section_name"
        case section_image = "section_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        section_id = try values.decodeIfPresent(Int.self, forKey: .section_id)
        section_name = try values.decodeIfPresent(String.self, forKey: .section_name)
        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
    }

}
