//
//  AddNewTaskVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 09/10/2022.
//

import UIKit


class AddNewTaskVC: UIViewController {
    
    var staffID = ""

    @IBOutlet var taskDetailsText: UITextView!
    @IBOutlet var totalAmountText: UITextField!
    @IBOutlet var postCodeText: UITextField!
    @IBOutlet var shopNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        blurEffect()
    
        
    }
    

    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateToday = formatter.string(from: date)
       
        GetStaffData().addStaffTask(id: staffID, date: dateToday, done: "", paymentDone: "", shopDetails: "\(shopNameText.text!) \(postCodeText.text!)", staffOk: "", taskDetail: taskDetailsText.text!, paymentDetails: totalAmountText.text!)
        
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func blurEffect() {
          
          let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
          let blurEffectView = UIVisualEffectView(effect: blurEffect)
          blurEffectView.frame = view.bounds
          blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          view.addSubview(blurEffectView)
      }
      
      func removeBlurView() {
          for subview in view.subviews {
              if subview.isKind(of: UIVisualEffectView.self) {
                  subview.removeFromSuperview()
              }
          }
      }
    
  

}
