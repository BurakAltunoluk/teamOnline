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
    
    func getAllStaffData(staffId: @escaping(String) -> (), staffTitle: @escaping(String) -> (), staffName: @escaping(String) -> () )   {
        fireStore.collection("Edell Coffee").document("admin").collection("staff").addSnapshotListener { datam, error in
            if datam != nil {
                for i in datam!.documents {
                    let name = i.get("fullName")! as! String
                    staffName(name)
                    let title1 = i.get("title")! as! String
                    staffTitle(title1)
                    let id = i.documentID
                    staffId(id)
                }
            }
        }
    }
    
    
    func getStaffData(id: String, staffData: @escaping(Staff) -> ()) {
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
    
    
    func deleteStaff(id:String) {
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(id).delete()
    }
    
    func editStaffData(key:String, value:String, id:String) {
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document(id).setData([key:value], merge: true) { error in
            
        }
    }
    
    func getStaffTasks(staffTasks: @escaping(StaffTaskModel) -> ()) {
        
        fireStore.collection("Edell Coffee").document("admin").collection("staff").document("7GyieBnsoXYT9xrdDQvt").collection("tasks").addSnapshotListener { datam, error in
            
            for i in datam!.documents {
                var a = StaffTaskModel(id: "", date: "", done: "", paymentDone: "", shopDetails: "", staffOk: "", taskDetail: "")
                
                a.id = "7GyieBnsoXYT9xrdDQvt"
                a.date = i.get("date") as! String
                a.done = i.get("done") as! String
                a.paymentDone = i.get("paymentDone") as! String
                a.staffOk = i.get("staffOk") as! String
                a.taskDetail = i.get("taskDetail") as! String
                a.shopDetails = i.get("shopDetails") as! String
               
                staffTasks(a)
            }
        }
    }
}



