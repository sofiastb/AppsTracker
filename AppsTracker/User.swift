//
//  User.swift
//  This code creates a model for the User object. It takes information from the Firebase database and converts it into object form.
//
//  Created by Sofia Stanescu-Bellu on 2/7/17.
//
//

import Foundation
import FirebaseAuth

struct User {
    
    // Defines the User object's properties
    let uid: String
    let email: String
    
    // Initializes a FIRUser
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    // Initializes the User object
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
