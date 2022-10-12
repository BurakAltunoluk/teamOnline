//
//  WebServices.swift
//  Team Online
//
//  Created by Burak Altunoluk on 03/10/2022.
//

import Foundation
import Firebase

struct GetStaffData {
    let fireStore = Firestore.firestore()
    
    func getStaffNameAndTitle(staffId: @escaping([String]) -> (), staffTitle: @escaping([String]) -> (), staffName: @escaping([String]) -> () )   {
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").addSnapshotListener { datam, error in
            var staffIDArray = [String]()
            var staffTitleArray = [String]()
            var staffNameArray = [String]()
            if datam != nil {
                for i in datam!.documents {
                    let name = i.get("fullName")! as! String
                    staffNameArray.append(name)
                    staffName(staffNameArray)
                    let title1 = i.get("title")! as! String
                    staffTitleArray.append(title1)
                    staffTitle(staffTitleArray)
                    let id = i.documentID
                    staffIDArray.append(id)
                    staffId(staffIDArray)
                }
            }
        }
    }
    
    
    func getStaffDetails(id: String, staffData: @escaping(Staff) -> ()) {
        var staff = Staff(fullName: "", title: "", dateOfBirth: "", phoneNumber: "", address: "")
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(id).getDocument { datam, error in
            
            staff.fullName = datam?.get("fullName") as! String
            staff.title = datam?.get("title") as! String
            staff.address = datam?.get("address") as! String
            staff.phoneNumber = datam?.get("phoneNumber") as! String
            staff.dateOfBirth = datam?.get("dateOfBirth") as! String
            staffData(staff)
        }
    }
    
    func addNewStaff(name:String,title:String,dateOfBirth:String,phone:String,address:String) {
        
        let staffInfo = ["fullName":name,"title":title,"dateOfBirth":dateOfBirth,"phoneNumber":phone,"address":address]
        
        
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").addDocument(data: staffInfo) { error in
        }
    }
    
    func addStaffTask(id: String, date: String, done: String, paymentDone: String, shopDetails: String, staffOk: String, taskDetail: String, paymentDetails: String) {
        
        let newTask = ["date":date, "done":done, "paymentDone":paymentDone, "shopDetails": shopDetails, "staffOk": staffOk, "taskDetails": taskDetail, "paymentDetails": paymentDetails]
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(id).collection("tasks").addDocument(data: newTask) { error in
            print(error?.localizedDescription ?? "Task Add Error")
        }
    }
    
    func deleteStaff(id:String) {
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(id).delete()
    }
    
    func editStaff(key:String, value:String, id:String) {
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(id).setData([key:value], merge: true) { error in
            
        }
    }
    
    func getStaffTasks(id: String, staffTasks: @escaping([StaffTaskModel]) -> ()) {
        var tasksArray = [StaffTaskModel]()

        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(id).collection("tasks").addSnapshotListener { datam, error in
            
            if datam != nil {
                
                for i in datam!.documents {
                    var a = StaffTaskModel(taskID: "", date: "", done: "", paymentDone: "", shopDetails: "", staffOk: "", taskDetail: "", paymentDetail: "")
                    
                    
                    a.taskID = i.documentID
                    a.date = i.get("date") as? String ?? ""
                    a.done = i.get("done") as? String ?? ""
                    a.paymentDone = i.get("paymentDone") as? String ?? ""
                    a.staffOk = i.get("staffOk") as? String ?? ""
                    a.taskDetail = i.get("taskDetails") as? String ?? ""
                    a.shopDetails = i.get("shopDetails") as? String ?? ""
                    a.paymentDetail = i.get("paymentDetails") as? String ?? ""
                    
                    
                    tasksArray.append(a)
                    
                    staffTasks(tasksArray)
                }
            }
        }
    }
    
    func deleteStaffTask(staffID: String, taskID: String) {
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(staffID).collection("tasks").document(taskID).delete()
        
    }
}



