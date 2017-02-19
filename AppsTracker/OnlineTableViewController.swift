//
//  OnlineTableViewController.swift
//  AppsTracker
//
//  Created by Sofia Stanescu-Bellu on 2/8/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OnlineTableViewController: UITableViewController {

    // MARK: Constants
    let userCell = "UserCell"
    let usersRef = FIRDatabase.database().reference(withPath: "online")
    
    // MARK: Properties
    var currentUsers: [String] = []
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets the list of logged on users from Firebase.
        usersRef.observe(.childAdded, with: { snap in
            guard let email = snap.value as? String else { return }
            self.currentUsers.append(email)
            let row = self.currentUsers.count - 1
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .top)
        })
        
        // Checks to see if someone logged out.
        usersRef.observe(.childRemoved, with: { snap in
            guard let emailToFind = snap.value as? String else { return }
            for (index, email) in self.currentUsers.enumerated() {
                if email == emailToFind {
                    let indexPath = IndexPath(row: index, section: 0)
                    self.currentUsers.remove(at: index)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        })
    }
    
    // MARK: UITableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUsers.count
    }
    
    // Populates the logged in users cell.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath)
        let onlineUserEmail = currentUsers[indexPath.row]
        cell.textLabel?.text = onlineUserEmail
        return cell
    }
    
    // MARK: Actions
    // Allows the user to sign out when the sign out button is pressed.
    @IBAction func signoutButtonPressed(_ sender: AnyObject) {
        do {
            try! FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
            print("user signed out")
            if FIRAuth.auth()?.currentUser != nil {
                print("user is signed in")
            } else {
                print("user is not signed in")
            }
        } catch {
            
        }
    }
}
