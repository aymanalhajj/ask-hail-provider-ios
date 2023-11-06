//
//  Add-Remove-Comment.swift
//  AskHail
//
//  Created by Abdullah on 03/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct CommentModel : Codable {
    let status : Bool?
    let code : String?
    let data : CommentData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(CommentData.self, forKey: .data)
    }

}

struct CommentData : Codable {
    let message : String?
    let comment_id : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case comment_id = "comment_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        comment_id = try values.decodeIfPresent(Int.self, forKey: .comment_id)
    }

}

