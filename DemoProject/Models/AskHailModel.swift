//
//  AskHailModel.swift
//  AskHail
//
//  Created by bodaa on 14/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct AskHailModel: Codable {
    let status : Bool?
    let code : String?
    let data : AskHailData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AskHailData.self, forKey: .data)
    }

}

struct AskHailData : Codable {
    let data : [AskData]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AskData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct AskData : Codable {
    let question_id : Int?
    let question_advertiser_id: Int?
    let question_image : String?
    let question_show_name_status : String?
    let question_advertiser_name : String?
    let question_title : String?
    let question_custom_date : String?
    let question_replies_text : String?
    let question_date_status : String?
    let question_last_update : String?
    let question_created_at : String?
    let question_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case question_id = "question_id"
        case question_advertiser_id = "question_advertiser_id"
        case question_image = "question_image"
        case question_show_name_status = "question_show_name_status"
        case question_advertiser_name = "question_advertiser_name"
        case question_title = "question_title"
        case question_custom_date = "question_custom_date"
        case question_replies_text = "question_replies_text"
        case question_date_status = "question_date_status"
        case question_last_update = "question_last_update"
        case question_created_at = "question_created_at"
        case question_updated_at = "question_updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question_id = try values.decodeIfPresent(Int.self, forKey: .question_id)
        question_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .question_advertiser_id)
        question_image = try values.decodeIfPresent(String.self, forKey: .question_image)
        question_show_name_status = try values.decodeIfPresent(String.self, forKey: .question_show_name_status)
        question_advertiser_name = try values.decodeIfPresent(String.self, forKey: .question_advertiser_name)
        question_title = try values.decodeIfPresent(String.self, forKey: .question_title)
        question_custom_date = try values.decodeIfPresent(String.self, forKey: .question_custom_date)
        question_replies_text = try values.decodeIfPresent(String.self, forKey: .question_replies_text)
        question_date_status = try values.decodeIfPresent(String.self, forKey: .question_date_status)
        question_last_update = try values.decodeIfPresent(String.self, forKey: .question_last_update)
        question_created_at = try values.decodeIfPresent(String.self, forKey: .question_created_at)
        question_updated_at = try values.decodeIfPresent(String.self, forKey: .question_updated_at)
    }

}


//MARK:SHOW ASK Details

struct ShowAskDetailsModel : Codable {
    let status : Bool?
    let code : String?
    let data : ShowAskDetailsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(ShowAskDetailsData.self, forKey: .data)
    }

}

struct ShowAskDetailsData : Codable {
    let question_details : Question_details?
    let comments_count : String?
    let comments_data : [Comments_data]?
    let comments_pagination : Comments_pagination?

    enum CodingKeys: String, CodingKey {

        case question_details = "question_details"
        case comments_count = "comments_count"
        case comments_data = "comments_data"
        case comments_pagination = "comments_pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question_details = try values.decodeIfPresent(Question_details.self, forKey: .question_details)
        comments_count = try values.decodeIfPresent(String.self, forKey: .comments_count)
        comments_data = try values.decodeIfPresent([Comments_data].self, forKey: .comments_data)
        comments_pagination = try values.decodeIfPresent(Comments_pagination.self, forKey: .comments_pagination)
    }

}

struct Question_details : Codable {
    let question_id : Int?
    let question_image : String?
    let question_show_name_status : String?
    let question_title : String?
    let question_custom_published_date : String?
    let question_custom_last_update_date : String?
    let question_description : String?
    let question_last_update : String?
    let question_created_at : String?
    let question_updated_at : String?
    let question_advertiser_name : String?
    let question_advertiser_id : Int?

    enum CodingKeys: String, CodingKey {

        case question_id = "question_id"
        case question_image = "question_image"
        case question_show_name_status = "question_show_name_status"
        case question_title = "question_title"
        case question_custom_published_date = "question_custom_published_date"
        case question_custom_last_update_date = "question_custom_last_update_date"
        case question_description = "question_description"
        case question_last_update = "question_last_update"
        case question_created_at = "question_created_at"
        case question_updated_at = "question_updated_at"
        case question_advertiser_name = "question_advertiser_name"
        case question_advertiser_id = "question_advertiser_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question_id = try values.decodeIfPresent(Int.self, forKey: .question_id)
        question_image = try values.decodeIfPresent(String.self, forKey: .question_image)
        question_show_name_status = try values.decodeIfPresent(String.self, forKey: .question_show_name_status)
        question_title = try values.decodeIfPresent(String.self, forKey: .question_title)
        question_custom_published_date = try values.decodeIfPresent(String.self, forKey: .question_custom_published_date)
        question_custom_last_update_date = try values.decodeIfPresent(String.self, forKey: .question_custom_last_update_date)
        question_description = try values.decodeIfPresent(String.self, forKey: .question_description)
        question_last_update = try values.decodeIfPresent(String.self, forKey: .question_last_update)
        question_created_at = try values.decodeIfPresent(String.self, forKey: .question_created_at)
        question_updated_at = try values.decodeIfPresent(String.self, forKey: .question_updated_at)
        question_advertiser_name = try values.decodeIfPresent(String.self, forKey: .question_advertiser_name)
        question_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .question_advertiser_id)
        
    }

}

//MARK:Success Update Ask

struct SuccessUpdateAskModel : Codable {
    let status : Bool?
    let code : String?
    let data : SuccessUpdateAskData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(SuccessUpdateAskData.self, forKey: .data)
    }

}

struct SuccessUpdateAskData : Codable {
    let message : String?
    let question_id : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case question_id = "question_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        question_id = try values.decodeIfPresent(Int.self, forKey: .question_id)
    }

}


