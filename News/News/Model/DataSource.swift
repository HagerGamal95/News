//
//  DataSource.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation
import RealmSwift

struct DataSource {
    func fetchHeadlines(country :Country? , categories : [Category]?, pageSize: Int , onSuccess: @escaping ([Article]) -> Void, onFailure: @escaping (ServiceError) -> Void){
        let dispatchGroup = DispatchGroup()
        
        var totalArticles = [Article]()
        var generalError: ServiceError?
        
        categories?.forEach({ category in
            guard let country = country else { return }
            dispatchGroup.enter()
            
            let headlinesRequest = HeadlinesRequest(country: country.rawValue, category: category.rawValue, pageSize: 20)
            APIFetcher().fetch(request: headlinesRequest, mappingInResponse: BaseResponse<Article>.self) { response in
                if let articles = response.articles {
                    totalArticles.append(contentsOf: articles)
                }
                dispatchGroup.leave()
            } onFailure: { error in
                generalError = error
                dispatchGroup.leave()
            }
        })
        
        dispatchGroup.notify(queue: .main) {
            if let error = generalError {
                onFailure(error)
            } else {
                var articles = totalArticles.sorted(by: { (lhs, rhs) -> Bool in
                    guard let lhsDate = lhs.publishedAt, let rhsDate = rhs.publishedAt else { return false }
                    return lhsDate.timeIntervalSince1970 < rhsDate.timeIntervalSince1970
                })
                
                setArticlesSavedValue(articles: &articles)
                onSuccess(articles)
            }
        }
    }
    
    func fetchSearchResult(query: String, language: String, pageSize: Int, onSuccess: @escaping ([Article]) -> Void, onFailure: @escaping (ServiceError) -> Void){
        let searchsRequest = SearchRequest(query: query, language: language, pageSize: 20)
        APIFetcher().fetch(request: searchsRequest, mappingInResponse: BaseResponse<Article>.self) { response in
            var articles = response.articles ?? []
            setArticlesSavedValue(articles: &articles)
            onSuccess(articles)
        }
        onFailure: { error in
            onFailure(error)
        }
    }
    
    private func setArticlesSavedValue(articles: inout [Article]) {
        guard let savedArticles = try? loadArticles() else { return }
        articles.forEach { article in
            article.isSaved = savedArticles.contains { $0.url == article.url }
        }
    }
    
    func save(article: Article) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(article, update: .modified)
        }
    }
    
    func loadArticles() throws -> [Article] {
        let realm = try Realm()
        return Array(realm.objects(Article.self))
    }
    
    func delete(article: Article) throws {
        guard let url = article.url else { return }
        let realm = try Realm()
        let article = realm.objects(Article.self).filter("url == %@", url)
        try realm.write {
            realm.delete(article)
        }
    }
    
    func save(settings: Setting?) {
        UserDefaults.set(object: settings, withkey: kSetting)
    }
    
    func loadSettings() -> Setting? {
        UserDefaults.get(withKey: kSetting)
    }
}
