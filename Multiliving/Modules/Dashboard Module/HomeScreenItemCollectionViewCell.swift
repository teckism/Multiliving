//
//  HomeScreenItemCollectionViewCell.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class HomeScreenItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewForIcon: UIImageView!
    @IBOutlet weak var labelForTitle: UILabel!
    
    func loadItem(item : DashboardMenuItem){
        self.imageViewForIcon.image = UIImage.init(named: item.image)
        self.labelForTitle.text = item.name
    }
}
