//
//  ProductsDetailsVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 17/10/2022.
//

import UIKit

final class ProductsDetailsVC: UIViewController {
    @IBOutlet private var tableView: UITableView!
    var productSign = 0
    
    var choosedType = ""
    var products = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.layer.cornerRadius = 7
        tableView.reloadData()
        setup()
       
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addNewProduct()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    func setup() {
        
        ProductsData().getProductDetails(type1: choosedType) { datam in
            
            self.products = datam
            self.tableView.reloadData()
        }
    }


}

extension ProductsDetailsVC: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsCell", for: indexPath) as! ProductDetailsCell
        cell.productName.text = products[indexPath.row].nameOfProduct
        cell.details.text = products[indexPath.row].detailsOfProduct
        cell.priceLabel.text = "£ \(products[indexPath.row].priceOfProduct)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
          
            ProductsData().deleteProduct(productID: products[indexPath.row].productID)
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if productSign == 1 {
            choosedProduct = products[indexPath.row].nameOfProduct
            choosedProductPrice = Int(products[indexPath.row].priceOfProduct)!
            dismiss(animated: true)
            
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
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { data in
            let firstTextField = menu.textFields![0] as UITextField
            let secondTextField = menu.textFields![1] as UITextField
            let thirtTextField = menu.textFields![2] as UITextField
            
          
            ProductsData().addNewProduct(name: firstTextField.text!, price: secondTextField.text!, type: self.choosedType, details: thirtTextField.text!)
            
          
        }
        
       
        
       
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
       
        menu.addAction(saveButton)
        menu.addAction(cancelButton)
        present(menu, animated: true)
    }
    
    
    
}
