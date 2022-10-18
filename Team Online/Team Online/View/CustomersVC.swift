//
//  CustomersVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 10/10/2022.
//

import UIKit

class CustomersVC: UIViewController {
    
    var sendInfoToNewTask = 0
    @IBOutlet var searchBar: UISearchBar!
    private var customersArray = [CustomerModel]()
    @IBOutlet var tableView: UITableView!
    private var filteredData = [CustomerModel]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
    }
    
    func getData(){
        customersArray = [CustomerModel]()
        CustomersData().getAllCustomersData { datam in
            
                self.customersArray = datam
                
            self.filteredData = self.customersArray
            self.tableView.reloadData()
        }
    }
}





extension CustomersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomersCell") as! CustomersCell
        cell.customerShopNameAndPostCode.text = "\(filteredData[indexPath.row].shopName) / \(filteredData[indexPath.row].postCode)"
        cell.customerNameAndPhone.text = "\(filteredData[indexPath.row].customerName)  /  \(filteredData[indexPath.row].phoneNumber)"
     
        
        
        
        cell.layer.cornerRadius = 9
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if sendInfoToNewTask == 1 {
           
            shopNamePass = filteredData[indexPath.row].shopName
            postCodePass = filteredData[indexPath.row].postCode
          
               dismiss(animated: true)
           
        
      
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            CustomersData().deleteCustomer(customerID: filteredData[indexPath.row].customerID)
            filteredData.remove(at: indexPath.row)
            
            self.tableView.reloadData()
            
        }
        
        
    }
    
    
}

extension CustomersVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = [CustomerModel]()
        var row = -1
        
        if searchText == "" {
            
            self.filteredData = self.customersArray
            self.tableView.reloadData()
        }
        
        for word in customersArray {
            row += 1
            if word.shopName.uppercased().contains(searchText.uppercased()){
                
                filteredData.append(customersArray[row])
            }
            
        }
        self.tableView.reloadData()
    }
    
    
    
    
    
}
