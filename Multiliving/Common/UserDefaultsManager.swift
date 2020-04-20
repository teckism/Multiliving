//
//  UserDefaultsManager.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class UserDefaultsManager: NSObject {
    
    
    static let shared : UserDefaultsManager = UserDefaultsManager()
    private override init() {super.init()}
    
    func saveUserInfoFromDictionary(dictionary : Dictionary<String, Any>) {
        
        let userDefaults = UserDefaults.standard
        
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        guard let archivedUser = try? decoder.decode(UserInfo.self, from: try!  JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted))
            else {
                return
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(archivedUser) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userinfo")
        }
        userDefaults.synchronize()
        
    }
    
    
    
    func getSavedUserInfo() -> UserInfo? {
        
        let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.object(forKey: "userinfo") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(UserInfo.self, from: decoded) {
                return loadedPerson
                
            }
        }
        return nil
    }
    
    
    func updateUser(user : UserInfo) {
        let userDefaults = UserDefaults.standard
        
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userinfo")
        }
        userDefaults.synchronize()
    }
}
