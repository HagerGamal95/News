//
//  Source.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
import RealmSwift

@objcMembers
class Source: Object, Codable {
    dynamic var id: String?
    dynamic var name: String?
}
