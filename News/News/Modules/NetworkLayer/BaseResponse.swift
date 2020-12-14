//
//  BaseResponse.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation
public protocol BaseResponseProtocol: Codable {
    var status: String? { get set }
    var totalResults:Int? { get set }
}
class BaseResponse<T: Codable>: BaseResponseProtocol {
    var status: String?
    var totalResults:Int?
    var articles: [T]?
}
