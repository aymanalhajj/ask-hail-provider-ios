//
//  inChatModel.swift
//  AskHail
//
//  Created by bodaa on 18/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct ChatModel : Codable {
    let status : Bool?
    let code : String?
    let data : inChatData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(inChatData.self, forKey: .data)
    }

}

struct inChatData : Codable {
    let chat_details : Chat_details?
    let messages_data : [Messages_data]?
    let messages_pagination : Messages_pagination?

    enum CodingKeys: String, CodingKey {

        case chat_details = "chat_details"
        case messages_data = "messages_data"
        case messages_pagination = "messages_pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chat_details = try values.decodeIfPresent(Chat_details.self, forKey: .chat_details)
        messages_data = try values.decodeIfPresent([Messages_data].self, forKey: .messages_data)
        messages_pagination = try values.decodeIfPresent(Messages_pagination.self, forKey: .messages_pagination)
    }

}

struct Chat_details : Codable {
    let chat_id : Int?
    let chat_type : String?
    let chat_adv_order_id : Int?
    let chat_other_name : String?
    let chat_title : String?
    let chat_last_message_date : String?
    let chat_created_at : String?
    let chat_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case chat_id = "chat_id"
        case chat_type = "chat_type"
        case chat_adv_order_id = "chat_adv_order_id"
        case chat_other_name = "chat_other_name"
        case chat_title = "chat_title"
        case chat_last_message_date = "chat_last_message_date"
        case chat_created_at = "chat_created_at"
        case chat_updated_at = "chat_updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chat_id = try values.decodeIfPresent(Int.self, forKey: .chat_id)
        chat_type = try values.decodeIfPresent(String.self, forKey: .chat_type)
        chat_adv_order_id = try values.decodeIfPresent(Int.self, forKey: .chat_adv_order_id)
        chat_other_name = try values.decodeIfPresent(String.self, forKey: .chat_other_name)
        chat_title = try values.decodeIfPresent(String.self, forKey: .chat_title)
        chat_last_message_date = try values.decodeIfPresent(String.self, forKey: .chat_last_message_date)
        chat_created_at = try values.decodeIfPresent(String.self, forKey: .chat_created_at)
        chat_updated_at = try values.decodeIfPresent(String.self, forKey: .chat_updated_at)
    }

}

struct Messages_data : Codable {
    let message_id : Int?
    let message_text : String?
    let message_custom_date : String?
    let message_if_mine : Bool?
    let message_created_at : String?
    let message_updated_at : String?
    let message_sender_id : Int?

    enum CodingKeys: String, CodingKey {

        case message_id = "message_id"
        case message_text = "message_text"
        case message_custom_date = "message_custom_date"
        case message_if_mine = "message_if_mine"
        case message_created_at = "message_created_at"
        case message_updated_at = "message_updated_at"
        case message_sender_id = "message_sender_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message_id = try values.decodeIfPresent(Int.self, forKey: .message_id)
        message_text = try values.decodeIfPresent(String.self, forKey: .message_text)
        message_custom_date = try values.decodeIfPresent(String.self, forKey: .message_custom_date)
        message_if_mine = try values.decodeIfPresent(Bool.self, forKey: .message_if_mine)
        message_created_at = try values.decodeIfPresent(String.self, forKey: .message_created_at)
        message_updated_at = try values.decodeIfPresent(String.self, forKey: .message_updated_at)
        message_sender_id = try values.decodeIfPresent(Int.self, forKey: .message_sender_id)
    }

}

struct Messages_pagination : Codable {
    let current_page : Int?
    let last_page : Int?
    let per_page : Int?
    let total : Int?
    let has_more_pages : Bool?

    enum CodingKeys: String, CodingKey {

        case current_page = "current_page"
        case last_page = "last_page"
        case per_page = "per_page"
        case total = "total"
        case has_more_pages = "has_more_pages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        last_page = try values.decodeIfPresent(Int.self, forKey: .last_page)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        has_more_pages = try values.decodeIfPresent(Bool.self, forKey: .has_more_pages)
    }

}
