//
//  ProductsData.swift
//  Team Online
//
//  Created by Burak Altunoluk on 13/10/2022.
//

import Foundation
import Firebase

struct ProductsData {
    let fireStore = Firestore.firestore()
    
    func getAllProductsType(type: @escaping([String])->()) {
        
        var typeArray = [String]()
        
        fireStore.collection("Edell Coffee").document("admin").collection("products").addSnapshotListener { datam, error in
            
           typeArray = []
           
            
            for type in datam!.documents{
                let productType = type.get("type")
                typeArray.append(productType as! String)
            }
            
    
            type(typeArray)
          
        }
    }
    
    func getProductDetails(type1: String, completion: @escaping([ProductModel]) -> ()) {
        var productsArray = [ProductModel]()
        
        fireStore.collection("Edell Coffee").document("admin").collection("products").addSnapshotListener { datam, error in
            productsArray = []
            for i in datam!.documents {
                
                var product = ProductModel(productID: "", nameOfProduct: "", priceOfProduct: "", detailsOfProduct: "")
                
                if i.get("type") as! String == type1 {
                    
                    product.productID = i.documentID
                    product.nameOfProduct = i.get("nameOfProduct") as! String
                    product.detailsOfProduct = i.get("detailsOfProduct") as! String
                    product.priceOfProduct = i.get("priceOfProduct") as! String
                    
                    productsArray.append(product)
                }
                
            }
            
            completion(productsArray)
        }
        
    }
    
    func deleteProduct(productID: String) {
        
        fireStore.collection("Edell Coffee").document("admin").collection("products").document(productID).delete()
        
    }
    
    func addNewProduct(name: String, price: String, type: String, details: String) {
        
        let newProduct = ["nameOfProduct": name, "priceOfProduct": price, "detailsOfProduct": details, "type": type]
    
        fireStore.collection("Edell Coffee").document("admin").collection("products").addDocument(data: newProduct) { error in
            
            print(error?.localizedDescription ?? "error")
            
        }
        
        
    }
    
}

