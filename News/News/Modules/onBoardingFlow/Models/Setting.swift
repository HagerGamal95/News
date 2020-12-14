//
//  Setting.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation

struct Setting : Codable{
    var country : Country?
    var language : Language?
    var categories : [Category]?
}
