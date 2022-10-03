//
//  StaffTableViewCell.swift
//  Team Online
//
//  Created by Burak Altunoluk on 01/10/2022.
//

import UIKit

class StaffTableViewCell: UITableViewCell {

   
    @IBOutlet var staffName: UILabel!
    @IBOutlet var staffTitle: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
