//
//  Article.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
import RealmSwift

@objcMembers
class Article: Object, Codable {
    dynamic var source: Source?
    dynamic var author: String?
    dynamic var title: String?
    dynamic var articleDescription: String?
    dynamic var url: String?
    dynamic var urlToImage: String?
    dynamic var publishedAt: Date?
    dynamic var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    override class func primaryKey() -> String? { "url" }
}
