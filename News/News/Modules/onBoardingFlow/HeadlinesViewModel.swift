////
////  HeadlinesViewModel.swift
////  News
////
////  Created by hager gamal on 12/14/20.
////
//
//import Foundation
//class HeadlinesViewModel : NSObject{
//    var articles : [Article]?
//    func fetchHeadlines(country :Country? , category : [Category]?, pageSize: Int , onSuccess: @escaping ([Article]?) -> Void, onFailure: @escaping (ServiceError) -> Void){
//        guard let country = country , let category = category?.first?.rawValue else {
//            return
//        }
//        let headlinesRequest = HeadlinesRequest(country: country.rawValue, category: category, pageSize: 20)
//        APIFetcher().fetch(request: headlinesRequest, mappingInResponse: BaseResponse<[Article]>.self) {[weak self] (response) in
//            print(response)
//            self?.articles = response.articles
//            onSuccess(response.articles)
//            
//        } onFailure: { error in
//            print(error)
//            onFailure(error)
//        }
//
//    }
//}
