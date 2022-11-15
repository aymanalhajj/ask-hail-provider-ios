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
    let data : FeaturesData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(FeaturesData.self, forKey: .data)
    }

}

struct FeaturesData : Codable {
    let advertisement : Advertisement?
    let section_features : [AdvertFeaturesModel]?

    enum CodingKeys: String, CodingKey {
        case advertisement = "advertisement"
        case section_features = "section_features"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisement = try values.decodeIfPresent(Advertisement.self, forKey: .advertisement)
        section_features = try values.decodeIfPresent([AdvertFeaturesModel].self, forKey: .section_features)
    }

}

struct Advertisement : Codable {
    let id : Int?
    let sub_section : Sub_section?
    var main_section : Main_section?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sub_section = "sub_section"
        case main_section = "main_section"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        sub_section = try values.decodeIfPresent(Sub_section.self, forKey: .sub_section)
        main_section = try values.decodeIfPresent(Main_section.self, forKey: .main_section)
    }

}

struct AdvertFeaturesModel : Codable {
    let featureId : Int?
    let featureName : String?
    let featureType : String?
    let featureData: [FeatureDataModel]?
    let selectedText:String?
    let selectedValue:String?

    enum CodingKeys: String, CodingKey {

        case featureId = "feature_id"
        case featureName = "feature_name"
        case featureType = "feature_type"
        case featureData = "feature_data"
        case selectedText = "selectedText"
        case selectedValue = "selectedValue"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        featureId = try values.decodeIfPresent(Int.self, forKey: .featureId)
        featureName = try values.decodeIfPresent(String.self, forKey: .featureName)
        featureType = try values.decodeIfPresent(String.self, forKey: .featureType)
        selectedText = try values.decodeIfPresent(String.self, forKey: .selectedText)
        selectedValue = try values.decodeIfPresent(String.self, forKey: .selectedValue)
        featureData = try values.decodeIfPresent([FeatureDataModel].self, forKey: .featureData)
    }

}

struct Sub_section : Codable {
    let id : Int?
    let section_type : String?
    let business_type : String?
    let name : String?
    let name_en : String?
    let image : String?
    let parent_id : Int?
    let available_status : String?
    let section_image : String?
    let admin_block : String?
    let admin_block_id : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case section_type = "section_type"
        case business_type = "business_type"
        case name = "name"
        case name_en = "name_en"
        case image = "image"
        case parent_id = "parent_id"
        case available_status = "available_status"
        case section_image = "section_image"
        case admin_block = "admin_block"
        case admin_block_id = "admin_block_id"
        case created_at = "created_at"
        case updated_at = "updated_at"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        section_type = try values.decodeIfPresent(String.self, forKey: .section_type)
        business_type = try values.decodeIfPresent(String.self, forKey: .business_type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
        parent_id = try values.decodeIfPresent(Int.self, forKey: .parent_id)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        admin_block = try values.decodeIfPresent(String.self, forKey: .admin_block)
        admin_block_id = try values.decodeIfPresent(Int.self, forKey: .admin_block_id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}

struct Main_section : Codable {
    let id : Int?
    let section_type : String?
    var business_type : String?
    let name : String?
    let name_en : String?
    let image : String?
    let parent_id : Int?
    let available_status : String?
    let section_image : String?
    let admin_block : String?
    let admin_block_id : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case section_type = "section_type"
        case business_type = "business_type"
        case name = "name"
        case name_en = "name_en"
        case image = "image"
        case parent_id = "parent_id"
        case available_status = "available_status"
        case section_image = "section_image"
        case admin_block = "admin_block"
        case admin_block_id = "admin_block_id"
        case created_at = "created_at"
        case updated_at = "updated_at"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        section_type = try values.decodeIfPresent(String.self, forKey: .section_type)
        business_type = try values.decodeIfPresent(String.self, forKey: .business_type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
        parent_id = try values.decodeIfPresent(Int.self, forKey: .parent_id)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        admin_block = try values.decodeIfPresent(String.self, forKey: .admin_block)
        admin_block_id = try values.decodeIfPresent(Int.self, forKey: .admin_block_id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}


struct FeatureDataModel : Codable {
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

////////////////////

//import Foundation
//struct FeaturesModel : Codable {
//    let status : Bool?
//    let code : String?
//    let data : [FeaturesData]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case status = "status"
//        case code = "code"
//        case data = "data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = try values.decodeIfPresent(Bool.self, forKey: .status)
//        code = try values.decodeIfPresent(String.self, forKey: .code)
//        data = try values.decodeIfPresent([FeaturesData].self, forKey: .data)
//    }
//
//}
//
//struct FeaturesData : Codable {
//    let feature_id : Int?
//    let feature_section : Featuree_section?
//    let feature_name : String?
//    let feature_type : String?
//    let feature_data : [Feature_data]?
//    let feature_options : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case feature_id = "feature_id"
//        case feature_section = "feature_section"
//        case feature_name = "feature_name"
//        case feature_type = "feature_type"
//        case feature_data = "feature_data"
//        case feature_options = "feature_options"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        feature_id = try values.decodeIfPresent(Int.self, forKey: .feature_id)
//        feature_section = try values.decodeIfPresent(Featuree_section.self, forKey: .feature_section)
//        feature_name = try values.decodeIfPresent(String.self, forKey: .feature_name)
//        feature_type = try values.decodeIfPresent(String.self, forKey: .feature_type)
//        feature_data = try values.decodeIfPresent([Feature_data].self, forKey: .feature_data)
//        feature_options = try values.decodeIfPresent(String.self, forKey: .feature_options)
//    }
//
//}
//
//struct Featuree_section : Codable {
//    let section_id : Int?
//    let section_name : String?
//    let section_image : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case section_id = "section_id"
//        case section_name = "section_name"
//        case section_image = "section_image"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        section_id = try values.decodeIfPresent(Int.self, forKey: .section_id)
//        section_name = try values.decodeIfPresent(String.self, forKey: .section_name)
//        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
//    }
//
//}
//
//struct Feature_data : Codable {
//    let data_id : Int?
//    let data_feature_id : Int?
//    let data_title : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case data_id = "data_id"
//        case data_feature_id = "data_feature_id"
//        case data_title = "data_title"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data_id = try values.decodeIfPresent(Int.self, forKey: .data_id)
//        data_feature_id = try values.decodeIfPresent(Int.self, forKey: .data_feature_id)
//        data_title = try values.decodeIfPresent(String.self, forKey: .data_title)
//    }
//
//}
