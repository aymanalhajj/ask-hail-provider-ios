//
//  ChatListModel.swift
//  AskHail
//
//  Created by bodaa on 18/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct ChatListModel : Codable {
    let status : Bool?
    let code : String?
    let data : ChatListData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(ChatListData.self, forKey: .data)
    }

}

struct ChatListData : Codable {
    let data : [ChatData]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ChatData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct ChatData : Codable {
    let chat_id : Int?
    let chat_title : String?
    let chat_image : String?
    let chat_last_message : String?
    let chat_last_message_date : String?
    let chat_unread_messages_count : Int?
    let chat_created_at : String?
    let chat_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case chat_id = "chat_id"
        case chat_title = "chat_title"
        case chat_image = "chat_image"
        case chat_last_message = "chat_last_message"
        case chat_last_message_date = "chat_last_message_date"
        case chat_unread_messages_count = "chat_unread_messages_count"
        case chat_created_at = "chat_created_at"
        case chat_updated_at = "chat_updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chat_id = try values.decodeIfPresent(Int.self, forKey: .chat_id)
        chat_title = try values.decodeIfPresent(String.self, forKey: .chat_title)
        chat_image = try values.decodeIfPresent(String.self, forKey: .chat_image)
        chat_last_message = try values.decodeIfPresent(String.self, forKey: .chat_last_message)
        chat_last_message_date = try values.decodeIfPresent(String.self, forKey: .chat_last_message_date)
        chat_unread_messages_count = try values.decodeIfPresent(Int.self, forKey: .chat_unread_messages_count)
        chat_created_at = try values.decodeIfPresent(String.self, forKey: .chat_created_at)
        chat_updated_at = try values.decodeIfPresent(String.self, forKey: .chat_updated_at)
    }

}
