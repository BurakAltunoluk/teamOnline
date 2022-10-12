//
//  TasksAndPaymentsVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 06/10/2022.
//

import UIKit


final class TasksAndPaymentsVC: UIViewController {
    var staffID = ""
    var taskID = ""
    var tasksOfStaff = [StaffTaskModel]()
    
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var tableView: UITableView!

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction private func addButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddNewTask", sender: nil)
        
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func setup() {
        GetStaffData().getStaffTasks(id: staffID) { datam in
          
            self.tasksOfStaff = datam
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddNewTask" {
            let destination = segue.destination as! AddNewTaskVC
            destination.staffID = self.staffID
        }
    }
    
}

extension TasksAndPaymentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksOfStaff.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksAndPaymentCell", for: indexPath) as! TasksAndPaymentCell
        cell.taskShopDetails.text = self.tasksOfStaff[indexPath.row].shopDetails
        cell.taskDetails.text = self.tasksOfStaff[indexPath.row].taskDetail
        cell.taskPayment.text = self.tasksOfStaff[indexPath.row].paymentDone
        cell.taskDate.text = self.tasksOfStaff[indexPath.row].date
        cell.taskPayment.text = "£\(self.tasksOfStaff[indexPath.row].paymentDetail)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.taskID = tasksOfStaff[indexPath.row].taskID
            GetStaffData().deleteStaffTask(staffID: self.staffID, taskID: taskID)
            
            self.tasksOfStaff.remove(at: indexPath.row)
            
            self.tableView.reloadData()
            
        }
    }
}
