//
//  TasksAndPaymentsVC.swift
//  Team Online
//
//  Created by Burak Altunoluk on 06/10/2022.
//

import UIKit

final class TasksAndPaymentsVC: UIViewController {
    var staffID = ""
    var tasksOfStaff = [StaffTaskModel]()
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction private func addButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func setup() {
        GetStaffData().getStaffTasks { datam in
          
            self.tasksOfStaff.append(datam)
            print(self.tasksOfStaff.count)
            self.tableView.reloadData()
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
        return cell
    }
    
    
    
}
