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
    @IBOutlet var backButtonOutlet: UIButton!
    @IBOutlet private var addNewButtonOutlet: UIButton!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewButtonOutlet.setTitle("", for: .normal)
        addNewButtonOutlet.layer.cornerRadius = 3
        backButtonOutlet.layer.cornerRadius = 3
        tableView.layer.cornerRadius = 9
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func addNewStaff(_ sender: UIButton) {
    }
    
    func getData() {
       
        GetStaffData().getStaffNameAndTitle { idData in
            self.allStaffId = idData
            self.tableView.reloadData()
        } staffTitle: { titleData in
            self.allStaffTitle = titleData
        } staffName: { nameData in
            self.allStaffName = nameData
        }
    }
    
    private func resetAllData() {
        self.allStaffName.removeAll()
        self.allStaffTitle.removeAll()
        self.allStaffId.removeAll()
        self.tableView.reloadData()
    }
}

extension StaffVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStaffId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! StaffTableViewCell
        cell.layer.cornerRadius = 9
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
            resetAllData()
            getData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! StaffDetailsVC
            destinationVC.staffID = self.staffIDtoSend
        }
    }
}

