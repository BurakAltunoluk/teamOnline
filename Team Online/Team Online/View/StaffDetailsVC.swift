//
//  StaffDetailsVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 02/10/2022.
//

import UIKit

class StaffDetailsVC: UIViewController {
    
    var staffID = ""
    private var staffData: Staff!
    
    @IBOutlet var editButtonOutlet: UIButton!
    
    @IBOutlet private var nameLabel: UITextField!
    @IBOutlet private var titleLabel: UITextField!
    @IBOutlet private var dateOfBirthLabel: UITextField!
    @IBOutlet private var phoneNumberLabel: UITextField!
    @IBOutlet private var addressLabel: UITextView!
    
    @IBAction func staffButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func tasksAndPaymentPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toTasks", sender: nil)
    }
    
    @IBAction func EditButtonPressed(_ sender: UIButton) {
        if editButtonOutlet.titleLabel?.text == "Edit" {
            editButtonOutlet.setTitle("Done", for: .normal)
           
            self.nameLabel.isEnabled = true
            self.titleLabel.isEnabled = true
            self.dateOfBirthLabel.isEnabled = true
            self.phoneNumberLabel.isEnabled = true
            self.addressLabel.isEditable = true
        } else {
            
            GetStaffData().editStaff(key: "fullName", value: nameLabel.text!, id: staffID)
            GetStaffData().editStaff(key: "title", value: titleLabel.text!, id: staffID)
            GetStaffData().editStaff(key: "phoneNumber", value: phoneNumberLabel.text!, id: staffID)
            GetStaffData().editStaff(key: "dateOfBirth", value: dateOfBirthLabel.text!, id: staffID)
            GetStaffData().editStaff(key: "address", value: addressLabel.text!, id: staffID)
            editButtonOutlet.setTitle("Edit", for: .normal)
            
             self.nameLabel.isEnabled = false
             self.titleLabel.isEnabled = false
             self.dateOfBirthLabel.isEnabled = false
             self.phoneNumberLabel.isEnabled = false
             self.addressLabel.isEditable = false
        }
       
      
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
     setup()
     
    }
    
    func setup() {
        
        GetStaffData().getStaffDetails(id: staffID) { data in
            self.staffData = data
            self.nameLabel.text = self.staffData.fullName
            self.titleLabel.text = self.staffData.title
            self.dateOfBirthLabel.text = self.staffData.dateOfBirth
            self.phoneNumberLabel.text = self.staffData.phoneNumber
            self.addressLabel.text = self.staffData.address
        }
        
          
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTasks" {
            let destinationVC = segue.destination as! TasksAndPaymentsVC
            destinationVC.staffID = self.staffID
        }
    }

}
