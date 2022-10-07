//
//  StaffVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 01/10/2022.
//

import UIKit


final class StaffVC: UIViewController {
    private var staffIDtoSend = ""
    private var allStaffName = [String]()
    private var allStaffTitle = [String]()
    private var allStaffId = [String]()
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.allStaffName = [String]()
        self.allStaffTitle = [String]()
        self.allStaffId = [String]()
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func addNewStaff(_ sender: UIButton) {
    }
    
    func getData() {
       
        GetStaffData().getAllStaffData { idData in
            self.allStaffId.append(idData)
            self.tableView.reloadData()
        } staffTitle: { titleData in
            self.allStaffTitle.append(titleData)
            self.tableView.reloadData()
        } staffName: { nameData in
            self.allStaffName.append(nameData)
            self.tableView.reloadData()
            
        }
        
    }
    
}

extension StaffVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStaffId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! StaffTableViewCell
        cell.staffName.text = allStaffName[indexPath.row]
        cell.staffTitle.text = allStaffTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.staffIDtoSend = allStaffId[indexPath.row].description
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            GetStaffData().deleteStaff(id: allStaffId[indexPath.row])
            allStaffId.remove(at: indexPath.row)
            allStaffName.remove(at: indexPath.row)
            allStaffTitle.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! StaffDetailsVC
            destinationVC.staffID = self.staffIDtoSend
        }
        
    }
    
}

