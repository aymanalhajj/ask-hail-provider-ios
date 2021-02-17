//
//  ShowAdModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 02/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct ShowBusinessAdvModel : Codable {
    let status : Bool?
    let code : String?
    let data : ShowBusinessAdvData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(ShowBusinessAdvData.self, forKey: .data)
    }

}


struct ShowBusinessAdvData : Codable {
    let advertisement_details : Advertisement_details?
    let rates_count : String?
    let rates_average : String?
    let rates_data : [Rates_data]?

    enum CodingKeys: String, CodingKey {

        case advertisement_details = "advertisement_details"
        case rates_count = "rates_count"
        case rates_average = "rates_average"
        case rates_data = "rates_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisement_details = try values.decodeIfPresent(Advertisement_details.self, forKey: .advertisement_details)
        rates_count = try values.decodeIfPresent(String.self, forKey: .rates_count)
        rates_average = try values.decodeIfPresent(String.self, forKey: .rates_average)
        rates_data = try values.decodeIfPresent([Rates_data].self, forKey: .rates_data)
    }

}


struct Advertisement_details : Codable {
    let adv_id : Int?
    let adv_type : String?
    let adv_is_favorite : Bool?
    let adv_special_status : String?
    let adv_media : [Adv_media]?
    let adv_promotional_image : String?
    let adv_title : String?
    let adv_price : String?
    let adv_distance : String?
    let adv_views : String?
    let adv_total_rate : String?
    let adv_custom_published_date : String?
    let adv_custom_last_update_date : String?
    let adv_last_update : String?
    let adv_description : String?
    let adv_specifications : [Adv_specifications]?
    let adv_location : String?
    let adv_latitude : String?
    let adv_longitude : String?
    let adv_main_section : Adv_main_section?
    let adv_sub_section : Adv_sub_section?
    let adv_advertiser_id : Int?
    let adv_advertiser_name : String?
    let adv_advertiser_advs_count : String?
    let adv_if_any_contact_available : Bool?
    let adv_call_number_status : String?
    let adv_call_number : String?
    let adv_whatsapp_number_status : String?
    let adv_whatsapp_number : String?
    let adv_twitter : String?
    let adv_instagram : String?
    let adv_snapchat : String?
    let adv_facebook : String?
    let adv_website : String?
    let adv_created_at : String?
    let adv_updated_at : String?
    let adv_available_status : String?
    let adv_available_custom_status : String?
    let isWaiting : Bool?
    let specification_answer_id : Int?
    let specification_answer : String?
    
    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_type = "adv_type"
        case adv_is_favorite = "adv_is_favorite"
        case adv_special_status = "adv_special_status"
        case adv_media = "adv_media"
        case adv_promotional_image = "adv_promotional_image"
        case adv_title = "adv_title"
        case adv_price = "adv_price"
        case adv_distance = "adv_distance"
        case adv_views = "adv_views"
        case adv_total_rate = "adv_total_rate"
        case adv_custom_published_date = "adv_custom_published_date"
        case adv_custom_last_update_date = "adv_custom_last_update_date"
        case adv_last_update = "adv_last_update"
        case adv_description = "adv_description"
        case adv_specifications = "adv_specifications"
        case adv_location = "adv_location"
        case adv_latitude = "adv_latitude"
        case adv_longitude = "adv_longitude"
        case adv_main_section = "adv_main_section"
        case adv_sub_section = "adv_sub_section"
        case adv_advertiser_id = "adv_advertiser_id"
        case adv_advertiser_name = "adv_advertiser_name"
        case adv_advertiser_advs_count = "adv_advertiser_advs_count"
        case adv_if_any_contact_available = "adv_if_any_contact_available"
        case adv_call_number_status = "adv_call_number_status"
        case adv_call_number = "adv_call_number"
        case adv_whatsapp_number_status = "adv_whatsapp_number_status"
        case adv_whatsapp_number = "adv_whatsapp_number"
        case adv_twitter = "adv_twitter"
        case adv_instagram = "adv_instagram"
        case adv_snapchat = "adv_snapchat"
        case adv_facebook = "adv_facebook"
        case adv_website = "adv_website"
        case adv_created_at = "adv_created_at"
        case adv_updated_at = "adv_updated_at"
        case adv_available_status = "adv_available_status"
        case adv_available_custom_status = "adv_available_custom_status"
        case isWaiting = "isWaiting"
        case specification_answer_id = "specification_answer_id"
        case specification_answer = "specification_answer"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
        adv_is_favorite = try values.decodeIfPresent(Bool.self, forKey: .adv_is_favorite)
        adv_special_status = try values.decodeIfPresent(String.self, forKey: .adv_special_status)
        adv_media = try values.decodeIfPresent([Adv_media].self, forKey: .adv_media)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
        adv_distance = try values.decodeIfPresent(String.self, forKey: .adv_distance)
        adv_views = try values.decodeIfPresent(String.self, forKey: .adv_views)
        adv_total_rate = try values.decodeIfPresent(String.self, forKey: .adv_total_rate)
        adv_custom_published_date = try values.decodeIfPresent(String.self, forKey: .adv_custom_published_date)
        adv_custom_last_update_date = try values.decodeIfPresent(String.self, forKey: .adv_custom_last_update_date)
        adv_last_update = try values.decodeIfPresent(String.self, forKey: .adv_last_update)
        adv_description = try values.decodeIfPresent(String.self, forKey: .adv_description)
        adv_specifications = try values.decodeIfPresent([Adv_specifications].self, forKey: .adv_specifications)
        adv_location = try values.decodeIfPresent(String.self, forKey: .adv_location)
        adv_latitude = try values.decodeIfPresent(String.self, forKey: .adv_latitude)
        adv_longitude = try values.decodeIfPresent(String.self, forKey: .adv_longitude)
        adv_main_section = try values.decodeIfPresent(Adv_main_section.self, forKey: .adv_main_section)
        adv_sub_section = try values.decodeIfPresent(Adv_sub_section.self, forKey: .adv_sub_section)
        adv_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
        adv_advertiser_name = try values.decodeIfPresent(String.self, forKey: .adv_advertiser_name)
        adv_advertiser_advs_count = try values.decodeIfPresent(String.self, forKey: .adv_advertiser_advs_count)
        adv_if_any_contact_available = try values.decodeIfPresent(Bool.self, forKey: .adv_if_any_contact_available)
        adv_call_number_status = try values.decodeIfPresent(String.self, forKey: .adv_call_number_status)
        adv_call_number = try values.decodeIfPresent(String.self, forKey: .adv_call_number)
        adv_whatsapp_number_status = try values.decodeIfPresent(String.self, forKey: .adv_whatsapp_number_status)
        adv_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .adv_whatsapp_number)
        adv_twitter = try values.decodeIfPresent(String.self, forKey: .adv_twitter)
        adv_instagram = try values.decodeIfPresent(String.self, forKey: .adv_instagram)
        adv_snapchat = try values.decodeIfPresent(String.self, forKey: .adv_snapchat)
        adv_facebook = try values.decodeIfPresent(String.self, forKey: .adv_facebook)
        adv_website = try values.decodeIfPresent(String.self, forKey: .adv_website)
        adv_created_at = try values.decodeIfPresent(String.self, forKey: .adv_created_at)
        adv_updated_at = try values.decodeIfPresent(String.self, forKey: .adv_updated_at)
        adv_available_status = try values.decodeIfPresent(String.self, forKey: .adv_available_status)
        adv_available_custom_status = try values.decodeIfPresent(String.self, forKey: .adv_available_custom_status)
        isWaiting = try values.decodeIfPresent(Bool.self, forKey: .isWaiting)
        specification_answer_id = try values.decodeIfPresent(Int.self, forKey: .specification_answer_id)
        specification_answer = try values.decodeIfPresent(String.self, forKey: .specification_answer)
        
    }

}

struct Adv_sub_section : Codable {
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


struct Adv_main_section : Codable {
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


struct Rates_data : Codable {
    let rate_id : Int?
    let rate_voter_id : Int?
    let rate_voter_name : String?
    let rate : Double?
    let rate_custom_date : String?
    let rate_created_at : String?
    let rate_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case rate_id = "rate_id"
        case rate_voter_id = "rate_voter_id"
        case rate_voter_name = "rate_voter_name"
        case rate = "rate"
        case rate_custom_date = "rate_custom_date"
        case rate_created_at = "rate_created_at"
        case rate_updated_at = "rate_updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rate_id = try values.decodeIfPresent(Int.self, forKey: .rate_id)
        rate_voter_id = try values.decodeIfPresent(Int.self, forKey: .rate_voter_id)
        rate_voter_name = try values.decodeIfPresent(String.self, forKey: .rate_voter_name)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        rate_custom_date = try values.decodeIfPresent(String.self, forKey: .rate_custom_date)
        rate_created_at = try values.decodeIfPresent(String.self, forKey: .rate_created_at)
        rate_updated_at = try values.decodeIfPresent(String.self, forKey: .rate_updated_at)
    }

}
