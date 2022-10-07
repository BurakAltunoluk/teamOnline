//
//  TasksAndPaymentCell.swift
//  Team Online
//
//  Created by Burak Altunoluk on 06/10/2022.
//

import UIKit

class TasksAndPaymentCell: UITableViewCell {

    @IBOutlet var taskShopDetails: UILabel!
    @IBOutlet var taskDetails: UITextView!
    @IBOutlet var taskPayment: UILabel!
    
    @IBOutlet var taskDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
