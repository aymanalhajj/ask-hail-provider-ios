//
//  CommentModel.swift
//  AskHail
//
//  Created by bodaa on 19/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct AllCommentModel : Codable {
    let status : Bool?
    let code : String?
    let data : AllCommentData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AllCommentData.self, forKey: .data)
    }

}

struct AllCommentData : Codable {
    let data : [Comments_data]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Comments_data].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }
}


struct SingleCommentModel : Codable {
    let status : Bool?
    let code : String?
    let data : singleCommentData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(singleCommentData.self, forKey: .data)
    }

}

struct singleCommentData : Codable {
    let message : String?
    let comment : Comments_data?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case comment = "comment"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        comment = try values.decodeIfPresent(Comments_data.self, forKey: .comment)
    }

}
