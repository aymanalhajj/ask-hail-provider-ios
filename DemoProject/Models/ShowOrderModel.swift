//
//  ShowOrderModel.swift
//  AskHail
//
//  Created by bodaa on 11/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct ShowOrderModel : Codable {
    let status : Bool?
    let code : String?
    let data : ShowOrderData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(ShowOrderData.self, forKey: .data)
    }

}

struct ShowOrderData : Codable {
    let order_details : Order_details?
    let comments_count : String?
    let comments_data : [Comments_data]?
    let comments_pagination : Comments_pagination?

    enum CodingKeys: String, CodingKey {

        case order_details = "order_details"
        case comments_count = "comments_count"
        case comments_data = "comments_data"
        case comments_pagination = "comments_pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_details = try values.decodeIfPresent(Order_details.self, forKey: .order_details)
        comments_count = try values.decodeIfPresent(String.self, forKey: .comments_count)
        comments_data = try values.decodeIfPresent([Comments_data].self, forKey: .comments_data)
        comments_pagination = try values.decodeIfPresent(Comments_pagination.self, forKey: .comments_pagination)
    }

}

struct Order_details : Codable {
    let order_id : Int?
    let order_title : String?
    let order_price : String?
    let order_custom_published_date : String?
    let order_custom_last_update_date : String?
    let order_description : String?
    let order_specifications : [Order_specifications]?
    let order_block : Order_block?
    let order_advertiser_name : String?
    let order_advertiser_advs_count : String?
    let order_if_any_contact_available : Bool?
    let order_call_number_status : String?
    let order_call_number : String?
    let order_whatsapp_number_status : String?
    let order_whatsapp_number : String?
    let order_last_update : String?
    let order_created_at : String?
    let order_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case order_title = "order_title"
        case order_price = "order_price"
        case order_custom_published_date = "order_custom_published_date"
        case order_custom_last_update_date = "order_custom_last_update_date"
        case order_description = "order_description"
        case order_specifications = "order_specifications"
        case order_block = "order_block"
        case order_advertiser_name = "order_advertiser_name"
        case order_advertiser_advs_count = "order_advertiser_advs_count"
        case order_if_any_contact_available = "order_if_any_contact_available"
        case order_call_number_status = "order_call_number_status"
        case order_call_number = "order_call_number"
        case order_whatsapp_number_status = "order_whatsapp_number_status"
        case order_last_update = "order_last_update"
        case order_created_at = "order_created_at"
        case order_updated_at = "order_updated_at"
        case order_whatsapp_number = "order_whatsapp_number"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        order_title = try values.decodeIfPresent(String.self, forKey: .order_title)
        order_price = try values.decodeIfPresent(String.self, forKey: .order_price)
        order_custom_published_date = try values.decodeIfPresent(String.self, forKey: .order_custom_published_date)
        order_custom_last_update_date = try values.decodeIfPresent(String.self, forKey: .order_custom_last_update_date)
        order_description = try values.decodeIfPresent(String.self, forKey: .order_description)
        order_specifications = try values.decodeIfPresent([Order_specifications].self, forKey: .order_specifications)
        order_block = try values.decodeIfPresent(Order_block.self, forKey: .order_block)
        order_advertiser_name = try values.decodeIfPresent(String.self, forKey: .order_advertiser_name)
        order_advertiser_advs_count = try values.decodeIfPresent(String.self, forKey: .order_advertiser_advs_count)
        order_if_any_contact_available = try values.decodeIfPresent(Bool.self, forKey: .order_if_any_contact_available)
        order_call_number_status = try values.decodeIfPresent(String.self, forKey: .order_call_number_status)
        order_call_number = try values.decodeIfPresent(String.self, forKey: .order_call_number)
        order_whatsapp_number_status = try values.decodeIfPresent(String.self, forKey: .order_whatsapp_number_status)
        order_last_update = try values.decodeIfPresent(String.self, forKey: .order_last_update)
        order_created_at = try values.decodeIfPresent(String.self, forKey: .order_created_at)
        order_updated_at = try values.decodeIfPresent(String.self, forKey: .order_updated_at)
        order_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .order_whatsapp_number)
    }

}


struct Order_block : Codable {
    let block_id : Int?
    let block_name : String?

    enum CodingKeys: String, CodingKey {

        case block_id = "block_id"
        case block_name = "block_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block_id = try values.decodeIfPresent(Int.self, forKey: .block_id)
        block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
    }

}
