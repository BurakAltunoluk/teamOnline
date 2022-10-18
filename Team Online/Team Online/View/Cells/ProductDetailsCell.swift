//
//  ProductDetailsCell.swift
//  Team Online
//
//  Created by Burak Altunoluk on 17/10/2022.
//

import UIKit

class ProductDetailsCell: UITableViewCell {

    @IBOutlet var productName: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var details: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
