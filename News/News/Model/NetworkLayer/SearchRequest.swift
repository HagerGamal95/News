//
//  SearchRequest.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation
import Alamofire

struct  SearchRequest : BaseRequestProtocol {
    let query:String
    let language:String
    let  pageSize : Int
    
    var url: String {
        return APIs.News.getAticleBySearch()
    }
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        let parameter = ["apiKey": kApiKey,
                         "q": self.query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "",
                         "language" : self.language,
                         "pageSize" : self.pageSize
            ] as [String : Any]
        
        return parameter
    }
    
    var headers: HTTPHeaders {
        return [keyParameters.contentTypeKey: keyParametersValues.contentTypeKey]
    }
}
