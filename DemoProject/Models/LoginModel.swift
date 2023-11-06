//
//  LoginModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 25/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct LoginModel : Codable {
    let status : Bool?
    let code : String?
    let data : LoginData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }

}

struct LoginData : Codable {
    let advertiser_id : Int?
    let advertiser_type : String?
    let advertiser_name : String?
    let advertiser_email : String?
    let advertiser_mobile : String?
    let advertiser_api_token : String?
    let advertiser_firebase_token : String?
    let advertiser_package_id : String?

    enum CodingKeys: String, CodingKey {

        case advertiser_id = "advertiser_id"
        case advertiser_type = "advertiser_type"
        case advertiser_name = "advertiser_name"
        case advertiser_email = "advertiser_email"
        case advertiser_mobile = "advertiser_mobile"
        case advertiser_api_token = "advertiser_api_token"
        case advertiser_firebase_token = "advertiser_firebase_token"
        case advertiser_package_id = "advertiser_package_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertiser_id = try values.decodeIfPresent(Int.self, forKey: .advertiser_id)
        advertiser_type = try values.decodeIfPresent(String.self, forKey: .advertiser_type)
        advertiser_name = try values.decodeIfPresent(String.self, forKey: .advertiser_name)
        advertiser_email = try values.decodeIfPresent(String.self, forKey: .advertiser_email)
        advertiser_mobile = try values.decodeIfPresent(String.self, forKey: .advertiser_mobile)
        advertiser_api_token = try values.decodeIfPresent(String.self, forKey: .advertiser_api_token)
        advertiser_firebase_token = try values.decodeIfPresent(String.self, forKey: .advertiser_firebase_token)
        advertiser_package_id = try values.decodeIfPresent(String.self, forKey: .advertiser_package_id)
    }

}
