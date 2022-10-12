//
//  GetCustomersData.swift
//  Team Online
//
//  Created by Burak Altunoluk on 11/10/2022.
//

import Foundation
import Firebase

struct CustomersData {
    let firestore = Firestore.firestore()
    
    func getAllCustomersData(completion: @escaping([CustomerModel])->()) {
      
        var customersArray = [CustomerModel]()
        
        firestore.collection("Edell Coffee").document("admin").collection("customers").addSnapshotListener { datam, error in
            
            if datam != nil {
                customersArray = [CustomerModel]()
                for i in datam!.documents{
                    
                    var customer = CustomerModel(shopName: "", address: "", postCode: "", customerName: "", phoneNumber: "", landLine: "", details: "")
                    customer.customerName = i.get("customerName") as! String
                    customer.phoneNumber = i.get("phoneNumber") as! String
                    customer.details = i.get("details") as! String
                    customer.shopName = i.get("shopName") as! String
                    customer.postCode = i.get("postCode") as! String
                    customer.address = i.get("address") as! String
    //                customer.landLine = i.get("landLine") as! String
                    
                    customersArray.append(customer)
                    
                    completion(customersArray)
                }
            }
        }
    }
    
    func addNewCustomer(shopName: String, address: String, postCode: String, customerName: String, phoneNumber: String, landLine: String, details:String, completion: @escaping(String) -> ()) {
        
        let newCustomer = ["shopName": shopName, "address": address, "postCode": postCode, "customerName": customerName, "phoneNumber": phoneNumber, "landLine": landLine, "details": details]
        
        firestore.collection("Edell Coffee").document("admin").collection("customers").addDocument(data: newCustomer) { error in
            
            if error != nil {
                completion("Error")
            } else {
                completion("")
            }
            
            
        }
        
        
    }
    
    
    
}
