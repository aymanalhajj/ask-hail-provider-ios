//
//  JobsModel.swift
//  AskHail
//
//  Created by bodaa on 28/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct JobsModel : Codable {
    let status : Bool?
    let code : String?
    let data : JobsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(JobsData.self, forKey: .data)
    }

}

struct JobsData : Codable {
    let data : [JubData]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([JubData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct JubData : Codable {
    let job_id : Int?
    let job_title : String?
    let job_description : String?

    enum CodingKeys: String, CodingKey {

        case job_id = "job_id"
        case job_title = "job_title"
        case job_description = "job_description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        job_id = try values.decodeIfPresent(Int.self, forKey: .job_id)
        job_title = try values.decodeIfPresent(String.self, forKey: .job_title)
        job_description = try values.decodeIfPresent(String.self, forKey: .job_description)
    }

}

struct JubPagination : Codable {
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
