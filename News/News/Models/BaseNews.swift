//
//  BaseNews.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation

// MARK: - BaseNews
struct BaseNews: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}
