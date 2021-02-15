//
//  AddAdsmodel.swift
//  AskHail
//
//  Created by bodaa on 01/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

//MARK:Check_level_1

struct Level_1_Model : Codable {
    let status : Bool?
    let code : String?
    let message : String?
    let data : Level_1_Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(Level_1_Data.self, forKey: .data)
    }

}

struct Level_1_Data : Codable {
    let advertisement_id : Int?
    let next_level : Int?

    enum CodingKeys: String, CodingKey {

        case advertisement_id = "advertisement_id"
        case next_level = "next_level"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisement_id = try values.decodeIfPresent(Int.self, forKey: .advertisement_id)
        next_level = try values.decodeIfPresent(Int.self, forKey: .next_level)
    }

}


struct Level_6_Model : Codable {
    let status : Bool?
    let code : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}



// MARK: BaseModel
struct AddAdsSelectPackageModel : Codable {
    let status : Bool?
    let code : String?
    let data : CkackPackgeData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(CkackPackgeData.self, forKey: .data)
    }

}

struct CkackPackgeData : Codable {
    let advertisement_id : Int?
    let next_level : Int?

    enum CodingKeys: String, CodingKey {

        case advertisement_id = "advertisement_id"
        case next_level = "next_level"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisement_id = try values.decodeIfPresent(Int.self, forKey: .advertisement_id)
        next_level = try values.decodeIfPresent(Int.self, forKey: .next_level)
    }

}

//MARK:- Success Model transAction



struct SuccessTransActionModel : Codable {
    let status : Bool?
    let code : String?
    let data : SuccessTransActionData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(SuccessTransActionData.self, forKey: .data)
    }

}

struct SuccessTransActionData : Codable {
    let message : String?
    let advertisement_id : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case advertisement_id = "advertisement_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        advertisement_id = try values.decodeIfPresent(Int.self, forKey: .advertisement_id)
    }

}

