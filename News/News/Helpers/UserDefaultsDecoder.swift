//
//  UserDefaultsDecoder.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
extension UserDefaults {

    static func get<T: Codable>(withKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let jsonDecoder = JSONDecoder()
                let user = try jsonDecoder.decode(T.self, from: data)
                return user
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    static func set<T: Codable>(object: T, withkey key: String) {
        do {
            let jsonEncoder = JSONEncoder()
            let encodedData = try jsonEncoder.encode(object)
            UserDefaults.standard.set(encodedData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
}
