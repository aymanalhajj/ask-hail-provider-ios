//
//  EditProfile.swift
//  AskHail
//
//  Created by bodaa on 12/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct EditProfileModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditProfileData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditProfileData.self, forKey: .data)
    }

}

struct EditProfileData : Codable {
    let message : String?
    let verify_mobile_status : Bool?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case verify_mobile_status = "verify_mobile_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        verify_mobile_status = try values.decodeIfPresent(Bool.self, forKey: .verify_mobile_status)
    }

}
