//
//  ProductsVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 13/10/2022.
//

import UIKit
import SwiftUI

class ProductsVC: UIViewController {
    var productSign = 0
    var typeArray = [String]()
    var choosedType = ""
    var productArray = [ProductModel]()
    var typeSet: Set<String> = []
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        collectionView.reloadData()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if productSign == 2 {
            dismiss(animated: true)
        }
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    @IBAction func addNewGroupButtonPressed(_ sender: UIButton) {
     addNewProduct()
    }
    
    func getData() {
    
        ProductsData().getAllProductsType { typeOfProduct in
            
            self.typeSet = Set(typeOfProduct)
            
            self.typeArray = Array(self.typeSet)
            
            
            self.collectionView.reloadData()
        }

       
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            
            let destinationVC = segue.destination as! ProductsDetailsVC
            destinationVC.choosedType = choosedType
            
        }
        
        if segue.identifier == "toDetails" {
            if productSign == 1 {
                let destination1 = segue.destination as! ProductsDetailsVC
                destination1.productSign = 1
            }
            
        }
    }
    
    func addNewProduct() {
        
        let menu = UIAlertController(title: "New Product", message: "", preferredStyle: .alert)
        
        menu.addTextField { nameTextField in
            nameTextField.placeholder = "Product Name"
        }
        
        menu.addTextField { priceTextField in
            priceTextField.placeholder = "Product Price"
        }
        menu.addTextField { detailsTextField in
            detailsTextField.placeholder = "Product Details"
        }
        menu.addTextField { type in
            type.placeholder = "Product Type"
        }
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { data in
            let firstTextField = menu.textFields![0] as UITextField
            let secondTextField = menu.textFields![1] as UITextField
            let thirtTextField = menu.textFields![2] as UITextField
            let fourtTextFiled = menu.textFields![3] as UITextField
            
          
            ProductsData().addNewProduct(name: firstTextField.text ?? "name", price: secondTextField.text ?? "price", type: fourtTextFiled.text ?? "type", details: thirtTextField.text ?? "details")
            
          
        }
        
       
        
       
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
       
        menu.addAction(saveButton)
        menu.addAction(cancelButton)
        present(menu, animated: true)
    }
    
}

extension ProductsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.layer.cornerRadius = 7
        cell.groupNameOfProducts.text = typeArray[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ElementListViewModel().sizeOfElement()
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.choosedType = typeArray[indexPath.row]
        
        performSegue(withIdentifier: "toDetails", sender: nil)
        self.productSign = 2
        
        }
}
