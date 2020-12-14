//
//  DataSource.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation

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
                let articles = totalArticles.sorted(by: { (lhs, rhs) -> Bool in
                    guard let lhsDate = lhs.publishedAt, let rhsDate = rhs.publishedAt else { return false }
                    return lhsDate.timeIntervalSince1970 < rhsDate.timeIntervalSince1970
                })
                onSuccess(articles)
            }
        }
    }
}
