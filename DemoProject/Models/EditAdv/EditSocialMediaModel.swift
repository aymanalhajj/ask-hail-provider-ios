//
//  EditSocialMediaModel.swift
//  AskHailBusiness
//
//  Created by bodaa on 06/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
struct EditSocialMediaModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditSocialMediaData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditSocialMediaData.self, forKey: .data)
    }

}


struct EditSocialMediaData : Codable {
    let adv_id : String?
    let adv_twitter : String?
    let adv_instagram : String?
    let adv_snapchat : String?
    let adv_facebook : String?
    let adv_website : String?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_twitter = "adv_twitter"
        case adv_instagram = "adv_instagram"
        case adv_snapchat = "adv_snapchat"
        case adv_facebook = "adv_facebook"
        case adv_website = "adv_website"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(String.self, forKey: .adv_id)
        adv_twitter = try values.decodeIfPresent(String.self, forKey: .adv_twitter)
        adv_instagram = try values.decodeIfPresent(String.self, forKey: .adv_instagram)
        adv_snapchat = try values.decodeIfPresent(String.self, forKey: .adv_snapchat)
        adv_facebook = try values.decodeIfPresent(String.self, forKey: .adv_facebook)
        adv_website = try values.decodeIfPresent(String.self, forKey: .adv_website)
    }

}
