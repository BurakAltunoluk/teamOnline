//
//  AddNewTaskVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 09/10/2022.
//

import UIKit


class AddNewTaskVC: UIViewController {
    var total = 0
    var staffID = ""
    @IBOutlet var taskDetailsText: UITextView!
    @IBOutlet var totalAmountText: UITextField!
    @IBOutlet var postCodeText: UITextField!
    @IBOutlet var shopNameText: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if choosedProduct != "" {
            taskDetailsText.text = "\(taskDetailsText.text ?? "")  \n  \(choosedProduct)   "
            totalAmountText.text = "£ \(total + choosedProductPrice)"
            total += choosedProductPrice
            choosedProduct = ""
            choosedProductPrice = 0
        }
        if shopNamePass != "" {
        
            self.shopNameText.text = shopNamePass
            self.postCodeText.text = postCodePass
            shopNamePass = ""
            postCodePass = ""
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addProductPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toProducts", sender: nil)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
       
    performSegue(withIdentifier: "getCustomerInfo", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "getCustomerInfo" {
            let destinationVC = segue.destination as! CustomersVC
            
            destinationVC.sendInfoToNewTask = 1
        }
        
        if segue.identifier == "toProducts" {
            
            let destinaoln1 = segue.destination as! ProductsVC
            destinaoln1.productSign = 1
            
        }
        
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
