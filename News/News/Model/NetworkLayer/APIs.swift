//
//  APIs.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation
class APIs {
    //MARK:- APIs Class
    struct News {
        static func getHeadlines() -> String {
            return "https://newsapi.org/v2/top-headlines"
        }
        static func getAticleBySearch() ->String {
            return "https://newsapi.org/v2/everything"
        }
    }
}
