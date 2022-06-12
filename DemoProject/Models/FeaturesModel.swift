//
//  FeaturesModel.swift
//  AskHail
//
//  Created by bodaa on 16/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
struct FeaturesModel : Codable {
    let status : Bool?
    let code : String?
    let data : [FeaturesData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([FeaturesData].self, forKey: .data)
    }

}

struct FeaturesData : Codable {
    let feature_id : Int?
    let feature_section : Featuree_section?
    let feature_name : String?
    let feature_type : String?
    let feature_data : [Feature_data]?
    let feature_options : String?

    enum CodingKeys: String, CodingKey {

        case feature_id = "feature_id"
        case feature_section = "feature_section"
        case feature_name = "feature_name"
        case feature_type = "feature_type"
        case feature_data = "feature_data"
        case feature_options = "feature_options"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        feature_id = try values.decodeIfPresent(Int.self, forKey: .feature_id)
        feature_section = try values.decodeIfPresent(Featuree_section.self, forKey: .feature_section)
        feature_name = try values.decodeIfPresent(String.self, forKey: .feature_name)
        feature_type = try values.decodeIfPresent(String.self, forKey: .feature_type)
        feature_data = try values.decodeIfPresent([Feature_data].self, forKey: .feature_data)
        feature_options = try values.decodeIfPresent(String.self, forKey: .feature_options)
    }

}

struct Featuree_section : Codable {
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

struct Feature_data : Codable {
    let data_id : Int?
    let data_feature_id : Int?
    let data_title : String?

    enum CodingKeys: String, CodingKey {

        case data_id = "data_id"
        case data_feature_id = "data_feature_id"
        case data_title = "data_title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data_id = try values.decodeIfPresent(Int.self, forKey: .data_id)
        data_feature_id = try values.decodeIfPresent(Int.self, forKey: .data_feature_id)
        data_title = try values.decodeIfPresent(String.self, forKey: .data_title)
    }

}
