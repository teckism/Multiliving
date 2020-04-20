//
//  HomeMenuGeneralItemTableViewCell.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class HomeMenuGeneralItemTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var labelForTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadItem(item : HomeMenuItem){
        
        self.labelForTitle.text = item.title
        
    }
}
