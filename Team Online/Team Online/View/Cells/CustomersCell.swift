//
//  CustomersCell.swift
//  Team Online
//
//  Created by Burak Altunoluk on 10/10/2022.
//

import UIKit

class CustomersCell: UITableViewCell {

    @IBOutlet var customerShopNameAndPostCode: UILabel!
    
    @IBOutlet var customerNameAndPhone: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }


    
}
