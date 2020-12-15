//
//  Article.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
import RealmSwift

@objcMembers
class Article: Object, Codable, NSCopying {
    dynamic var source: Source?
    dynamic var author: String?
    dynamic var title: String?
    dynamic var articleDescription: String?
    dynamic var url: String?
    dynamic var urlToImage: String?
    dynamic var publishedAt: Date?
    dynamic var content: String?
    var isSaved = false
    
    override init() {}
    
    init(source: Source? = nil, author: String? = nil, title: String? = nil, articleDescription: String? = nil, url: String? = nil, urlToImage: String? = nil, publishedAt: Date? = nil, content: String? = nil, isSaved: Bool = false) {
        self.source = source
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.isSaved = isSaved
    }

    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        Article(source: source?.copy() as? Source, author: author, title: title, articleDescription: articleDescription, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, isSaved: isSaved)
    }
    
    override class func primaryKey() -> String? { "url" }
    override class func ignoredProperties() -> [String] { ["isSaved"] }
}
