//
//  StaffVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 01/10/2022.
//

import UIKit

class StaffVC: UIViewController {
    var testArray = ["Hami","Sami","Fehmi","Ladi"]
    var testTitle = ["Sales manager","Boss","Director","Technical"]
    var testHidden = [true,true,true,true]
var a = true
    @IBOutlet var tableView: UITableView!
    @IBAction func addNewStaff(_ sender: UIButton) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension StaffVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! StaffTableViewCell
        cell.staffName.text = testArray[indexPath.row]
        cell.staffTitle.text = testTitle[indexPath.row]
        
        
        cell.stackView.isHidden = testHidden[indexPath.row]
        
        if testHidden[indexPath.row] == false {
            tableView.rowHeight = 170
        } else {
            tableView.rowHeight = 90
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        testHidden[indexPath.row].toggle()
        tableView.reloadData()
    }
}
