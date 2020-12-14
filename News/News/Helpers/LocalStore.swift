//
//  LocalStore.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation

struct LocalStore {
    static func loadSettings() -> Setting? {
        UserDefaults.get(withKey: kSetting)
    }
    
    static func save(settings: Setting?) {
        UserDefaults.set(object: settings, withkey: kSetting)
    }
}
