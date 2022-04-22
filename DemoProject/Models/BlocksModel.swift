//
//  BlocksModel.swift
//  AskHail
//
//  Created by bodaa on 27/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct BlocksModel : Codable {
    let status : Bool?
    let code : String?
    let data : [BlocksData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([BlocksData].self, forKey: .data)
    }

}

struct BlocksData : Codable {
    let block_id : String?
    let block_city : Block_city?
    let block_name : String?
    let admin_block_name : String?

    enum CodingKeys: String, CodingKey {

        case block_id = "block_id"
        case block_city = "block_city"
        case block_name = "block_name"
        case admin_block_name = "admin_block_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block_id = try values.decodeIfPresent(String.self, forKey: .block_id)
        block_city = try values.decodeIfPresent(Block_city.self, forKey: .block_city)
        block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
        admin_block_name = try values.decodeIfPresent(String.self, forKey: .admin_block_name)
    }

}

struct Block_city : Codable {
    let city_id : Int?
    let city_region : City_region?
    let city_name : String?
    let admin_city_name : String?

    enum CodingKeys: String, CodingKey {

        case city_id = "city_id"
        case city_region = "city_region"
        case city_name = "city_name"
        case admin_city_name = "admin_city_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_id = try values.decodeIfPresent(Int.self, forKey: .city_id)
        city_region = try values.decodeIfPresent(City_region.self, forKey: .city_region)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        admin_city_name = try values.decodeIfPresent(String.self, forKey: .admin_city_name)
    }

}
struct CitiesData : Codable {
    let city_id : Int?
    let city_region : City_region?
    let city_name : String?
    let admin_city_name : String?

    enum CodingKeys: String, CodingKey {

        case city_id = "city_id"
        case city_region = "city_region"
        case city_name = "city_name"
        case admin_city_name = "admin_city_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_id = try values.decodeIfPresent(Int.self, forKey: .city_id)
        city_region = try values.decodeIfPresent(City_region.self, forKey: .city_region)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        admin_city_name = try values.decodeIfPresent(String.self, forKey: .admin_city_name)
    }

}

struct City_region : Codable {
    let region_id : Int?
    let region_name : String?

    enum CodingKeys: String, CodingKey {

        case region_id = "region_id"
        case region_name = "region_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        region_id = try values.decodeIfPresent(Int.self, forKey: .region_id)
        region_name = try values.decodeIfPresent(String.self, forKey: .region_name)
    }

}
import Foundation
struct REgionModel : Codable {
    let status : Bool?
    let code : String?
    let data : [RegionData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([RegionData].self, forKey: .data)
    }

}

struct RegionData : Codable {
    let region_id : Int?
    let region_name : String?

    enum CodingKeys: String, CodingKey {

        case region_id = "region_id"
        case region_name = "region_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        region_id = try values.decodeIfPresent(Int.self, forKey: .region_id)
        region_name = try values.decodeIfPresent(String.self, forKey: .region_name)
    }

}

import Foundation
struct CitiesModel : Codable {
    let status : Bool?
    let code : String?
    let data : [CitiesData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([CitiesData].self, forKey: .data)
    }

}

