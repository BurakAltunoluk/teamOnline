//
//  NewCustomerVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 11/10/2022.
//

import UIKit

class NewCustomerVC: UIViewController {
    
    @IBOutlet var fullNameText: UITextField!
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var landLine: UITextField!
    @IBOutlet var shopName: UITextField!
    @IBOutlet var moreInfo: UITextView!
    @IBOutlet var address: UITextField!
    @IBOutlet var postCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
 
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func addedButtonPressed(_ sender: UIButton) {
       
        
//        CustomersData().addNewCustomer(shopName: shopName.text!, address: address.text!, postCode: postCode.text!, customerName: fullNameText.text!, phoneNumber: mobileNumber.text!, landLine: landLine.text!, details: moreInfo.text!)
        
        CustomersData().addNewCustomer(shopName: shopName.text!, address: address.text!, postCode: postCode.text!, customerName: fullNameText.text!, phoneNumber: mobileNumber.text!, landLine: landLine.text!, details: moreInfo.text!) { error in
           
            if error == "" { self.dismiss(animated: true)
                
            } else {print("Hatali bir durum olustu") }
            
        }
    }
    
}
