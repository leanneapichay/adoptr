//
//  MatchTableViewCell.swift
//  Adoptr
//
//  Created by Leanne Pichay on 30/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
