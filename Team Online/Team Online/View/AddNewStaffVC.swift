//
//  AddNewStaffVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 05/10/2022.
//

import UIKit

final class AddNewStaffVC: UIViewController {

    @IBOutlet private var fullNameText: UITextField!
    @IBOutlet private var titleText: UITextField!
    @IBOutlet private var dateOfBirthText: UITextField!
    @IBOutlet private var phoneNumberText: UITextField!
    @IBOutlet private var addressText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func addButtonPressed(_ sender: UIButton) {
        if fullNameText.text != "" && titleText.text != "" {
            
            GetStaffData().addNewStaff(name: fullNameText.text!, title: titleText.text!, dateOfBirth: dateOfBirthText.text ?? "", phone: phoneNumberText.text ?? "", address: addressText.text ?? "")
        }
        dismiss(animated: true)
    }
    
    @IBAction private func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
