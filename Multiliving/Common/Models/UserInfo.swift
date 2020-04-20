//
//  UserInfo.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class UserInfo: NSObject, Codable {
    
    var firstName: String?
    var lastName: String?
    let email: String?
    var dob: String?
    let phoneNumber: String?
    var aboutMe: String?
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case aboutMe = "about_me"
        case phoneNumber = "phone_number"
        case email,dob
    }
    
    
    
    init(firstName : String, lastName : String, aboutMe : String, phoneNumber: String, email : String, dob : String) {
        self.firstName = firstName
        self.lastName = lastName
        self.aboutMe = aboutMe
        self.phoneNumber = phoneNumber
        self.email = email
        self.dob = dob
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
    }
    
    
    
    //MARK: NSCoding protocol methods
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        
        try container.encode(lastName, forKey: .lastName)
        
        try container.encode(phoneNumber, forKey: .phoneNumber)
        
        try container.encode(aboutMe, forKey: .aboutMe)
        
        try container.encode(email, forKey: .email)
        
        try container.encode(dob, forKey: .dob)
        
    }
    

    
    
}
