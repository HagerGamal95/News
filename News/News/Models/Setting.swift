//
//  Setting.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
struct Setting : Codable{
    let country : Country?
    let language : Language?
    let categories : [Category]?
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case language = "language"
        case categories = "categories"

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decodeIfPresent(Country.self, forKey: .country)
        language = try values.decodeIfPresent(Language.self, forKey: .language)
        categories = try values.decodeIfPresent([Category].self, forKey: .categories)



    }
}
