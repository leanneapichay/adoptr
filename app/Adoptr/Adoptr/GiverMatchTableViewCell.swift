//
//  GiverMatchTableViewCell.swift
//  Adoptr
//
//  Created by Leanne Pichay on 3/6/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit

class GiverMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var adoptName: UILabel!
    @IBOutlet weak var petName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
