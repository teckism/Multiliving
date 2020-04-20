//
//  DashboardDataController.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class DashboardDataController: NSObject {
    
    
    
    func getUserDataFromJsonFile(){
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["user"] as?  Dictionary<String, Any>{
                    
                    UserDefaultsManager.shared.saveUserInfoFromDictionary(dictionary: person)
                    
                }
            } catch {
                // handle error
            }
        }
    }
    
    
}
