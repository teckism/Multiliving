//
//  Constants.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 16/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit


public struct Constants {
    static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    struct Alerts {
        static let kUnableToReachServer = "Unable to reach server"
        static let kErrorKey = "Error"
        
        static let kNoInternetConnection = "No Internet Connection"
        
    }
    
    struct WebServices {
        static let kGetListOfUsers = "5e8dcf95753e041b892bbefb"
        static let kLogin = ""
    }
    
    struct CellIdentifiers {
        static let kUserListItemCell = "userListItemCell"
        
    }
    struct Images {
        static let imageForHome = UIImage(named : "home")!
        static let imageForMenu = UIImage(named : "menu")!
        static let imageForClose = UIImage(named : "icon_close")!
        static let imageForBack = UIImage(named : "prev")!
    }
    
    struct StaticStrings {
        static let kStringForUserListTitle = "User Listing"
        
    }
    
    struct Colors {
        static let kSaveColor = UIColor(hex: "#FF9C55FF")
        static let kValidatedColor = UIColor(hex: "#5E7D96FF")
        static let kRemoveColor = UIColor.black
    }
}
