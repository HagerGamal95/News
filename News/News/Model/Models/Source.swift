//
//  Source.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
import RealmSwift

@objcMembers
class Source: Object, Codable, NSCopying {
    dynamic var id: String?
    dynamic var name: String?
    
    override init() {}
    
    init(id: String? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        Source(id: id, name: name)
    }
}
