// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myAdsModel = try? newJSONDecoder().decode(MyAdsModel.self, from: jsonData)

import Foundation

struct MyAdsModel : Codable {
    let status : Bool?
    let code : String?
    let data : MyAdsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(MyAdsData.self, forKey: .data)
    }

}

struct MyAdsData : Codable {
    let advertisements_count : String?
    let data : [AdsData]?
    let pagination : Pagination?
    let if_have_blocked_advertisements : Bool?

    enum CodingKeys: String, CodingKey {

        case advertisements_count = "advertisements_count"
        case data = "data"
        case pagination = "pagination"
        case if_have_blocked_advertisements = "if_have_blocked_advertisements"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisements_count = try values.decodeIfPresent(String.self, forKey: .advertisements_count)
        data = try values.decodeIfPresent([AdsData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        if_have_blocked_advertisements = try values.decodeIfPresent(Bool.self, forKey: .if_have_blocked_advertisements)
    }

}

struct AdsData : Codable {
    let adv_id : Int?
    let adv_type : String?
    let adv_advertiser_id : Int?
    let adv_special_status : String?
    let adv_promotional_image : String?
    let adv_title : String?
    var adv_is_favorite : Bool?
    let adv_price : String?
    let adv_distance : String?
    let adv_views : String?
    let adv_media : [Adv_media]?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_type = "adv_type"
        case adv_advertiser_id = "adv_advertiser_id"
        case adv_special_status = "adv_special_status"
        case adv_promotional_image = "adv_promotional_image"
        case adv_title = "adv_title"
        case adv_is_favorite = "adv_is_favorite"
        case adv_price = "adv_price"
        case adv_distance = "adv_distance"
        case adv_views = "adv_views"
        case adv_media = "adv_media"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
        adv_special_status = try values.decodeIfPresent(String.self, forKey: .adv_special_status)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_is_favorite = try values.decodeIfPresent(Bool.self, forKey: .adv_is_favorite)
        adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
        adv_distance = try values.decodeIfPresent(String.self, forKey: .adv_distance)
        adv_views = try values.decodeIfPresent(String.self, forKey: .adv_views)
        adv_media = try values.decodeIfPresent([Adv_media].self, forKey: .adv_media)
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
    }

}
