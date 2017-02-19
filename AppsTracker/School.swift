//
//  School.swift
//  This code creates a model for the school (college) object. It stores various infromation from the Firebase database and converts it into object form.
//  AppsTracker
//
//  Created by Sofia Stanescu-Bellu on 1/21/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct School {
    
    // Defines the properties of the school object
    let name: String
    let ea: String
    let ed: String
    let rd: String
    let mail: String
    let online: String
    let rec: String
    let schoolR: String
    let mid: String
    let supp: String
    var commonapp: String
    let ref: FIRDatabaseReference?
    
    // Initializes the school object
    init(name: String, ea: String, ed: String, rd: String, mail: String, online: String, rec: String, schoolR: String, mid: String, supp: String, commonapp: String) {
        self.name = name
        self.ea = ea
        self.ed = ed
        self.rd = rd
        self.mail = mail
        self.online = online
        self.rec = rec
        self.schoolR = schoolR
        self.mid = mid
        self.supp = supp
        self.commonapp = commonapp
        self.ref = nil
    }
    
    // Initializes the Firebase Snapshot
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        ea = snapshotValue["ea"] as! String
        ed = snapshotValue["ed"] as! String
        rd = snapshotValue["rd"] as! String
        mail = snapshotValue["mail"] as! String
        online = snapshotValue["online"] as! String
        rec = snapshotValue["recs"] as! String
        schoolR = snapshotValue["schoolr"] as! String
        mid = snapshotValue["mid"] as! String
        supp = snapshotValue["supp"] as! String
        if snapshotValue["commonapp"] == nil {
            commonapp = "No"
        } else {
            commonapp = snapshotValue["commonapp"] as! String
        }
        ref = snapshot.ref
    }
    
    // Allows the Data to be retrievable
    func toAnyObject() -> Any {
        return [
            "name": name,
            "ea": ea,
            "ed": ed,
            "rd": rd,
            "mail": mail,
            "online": online,
            "recs": rec,
            "schoolr": schoolR,
            "mid": mid,
            "supp": supp,
            "commonapp": commonapp,
        ]
    }
}
