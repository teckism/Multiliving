//
//  EditProfileDataController.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class EditProfileDataController: NSObject {
    
    var currentSelectedDate : Date?
    
    var userInfo : UserInfo = UserDefaultsManager.shared.getSavedUserInfo()!
    
    func saveUserProfile(name : String, aboutMe :  String, dob : String) {
        
        
        
        if let date = currentSelectedDate {
            
            userInfo.dob = date.toString(format: .custom("dd/MM/yyyy"))
            
        }
        
        
        if name.trim().count >= 3 {
            var enteredText = name.trim()
            //Replacing Multiple places with single space
            while enteredText.contains("  ") {
                enteredText = enteredText.replacingOccurrences(of: "  ", with: " ")
            }
            if enteredText.contains(" ") {

                let firstIndexOfSpace = enteredText.firstIndex(of: " ")!
                let index = enteredText.distance(from: enteredText.startIndex, to: firstIndexOfSpace)
                let firstName = enteredText.getSubstring(to: index)
                let lastName = enteredText.getSubstring(from: index + 1)

                userInfo.firstName = firstName
                userInfo.lastName = lastName
            }
        }
        userInfo.aboutMe = aboutMe.trim() 
        
        
        UserDefaultsManager.shared.updateUser(user: self.userInfo)
    }
    
    
    func isUIValidated(name : String, aboutMe :  String) -> Bool {
        //Validations
        
        
        if name.trim().count >= 3 {
            var enteredText = name.trim()
            //Replacing Multiple places with single space
            while enteredText.contains("  ") {
                enteredText = enteredText.replacingOccurrences(of: "  ", with: " ")
            }
            if !enteredText.contains(" ") {
                return false
            }
        }
        else{
            return false
        }
        
        return true
    }
    
}
