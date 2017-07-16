//
//  DescriptionTableViewCell.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 16.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionBookLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
