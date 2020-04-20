//
//  HomeMenuItem.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

enum MenuType {
    case profileInfo
    case notifications
    case paymentOptions
    case orders
}


struct HomeMenuItem {
    var title: String
    var subTitle: String?
    var type : MenuType
    
}
