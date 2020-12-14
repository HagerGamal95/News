//
//  HeadlinesRequest.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation
import Alamofire

class HeadlinesRequest : BaseRequestProtocol {
    let country:String
    let category:String
    let pageSize : Int
    
    init(country:String, category:String , pageSize : Int ) {
        self.country = country
        self.category = category
        self.pageSize = pageSize
    }
    var url: String {
        return APIs.News.getHeadlines()
    }
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        let parameter = ["apiKey": kApiKey,
                         "country": self.country ,
                         "category" : self.category,
                         "pageSize" : self.pageSize
            ] as [String : Any]
        
        return parameter
    }
    
    var headers: HTTPHeaders {
        return [keyParameters.contentTypeKey: keyParametersValues.contentTypeKey]
    }
}
struct keyParameters {
    static var contentTypeKey = "Content-Type"
}
struct keyParametersValues {
    static var contentTypeKey = "application/json"
}
