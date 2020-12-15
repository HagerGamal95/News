//
//  NetworkProtocols.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation
import Alamofire

protocol Fetcher {
    @discardableResult
    func fetch<ResponseType: BaseResponseProtocol> (request: BaseRequestProtocol, mappingInResponse response: ResponseType.Type, onSuccess: @escaping (ResponseType) -> Void, onFailure: @escaping (ServiceError) -> Void ) -> DataRequest?
}

protocol DataFetcher {
    var fetcher: Fetcher {get set}
}
