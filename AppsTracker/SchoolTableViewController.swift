//
//  SchoolTableViewController.swift
//  The main table view controller in the app. Here the user sees his or her list of schools and can check them individually to see the details. There is an empty data table view installed to make for a better user experience.
//  AppsTracker
//
//  Created by Sofia Stanescu-Bellu on 1/22/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import UIKit
import os.log
import FirebaseDatabase
import FirebaseAuth

class SchoolTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    //MARK: Properties
    var schools: [School] = []
    var user: User!
    var userCountBarButtonItem: UIBarButtonItem!
    
    // Firebase database references
    let ref = FIRDatabase.database().reference(withPath: "colleges")
    let onlineRef = FIRDatabase.database().reference(withPath: "online")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the datasource and delegate for the empty tableview.
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()

        
        // Sets up user login information button
        tableView.allowsMultipleSelectionDuringEditing = false
        
        userCountBarButtonItem = UIBarButtonItem(title: "1",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(userCountButtonDidTouch))
        userCountBarButtonItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = userCountBarButtonItem

        // Stores/loads user login data
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else {
                return
            }
            self.user = User(authData: user)
            let currentUserRef = self.onlineRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
        // Gets the number of currently logged on users to display in the left hand corner of the navigation bar.
        onlineRef.observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.userCountBarButtonItem?.title = snapshot.childrenCount.description
            } else {
                self.userCountBarButtonItem?.title = "0"
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: DZNEmptyTableView
    // Displays a welcome message in the empty table view.
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Welcome to AppsTracker!"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    // Displays a short message in the empty table view.
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tap the plus button to add your first school."
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    // Adds image to empty table view (optional)
//    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
//        return UIImage(named: "taylor-swift")
//    }
    
    // Adds button title to empty table view (optional)
//    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
//        let str = "Add Grokkleglob"
//        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout)]
//        return NSAttributedString(string: str, attributes: attrs)
//    }

    // Adds butto to empty table view (Optional)
//    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
//        let ac = UIAlertController(title: "Button tapped!", message: nil, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Hurray", style: .default))
//        present(ac, animated: true)
//    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }

    // Populates each colleges table view cell.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Sets up SchoolTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell", for: indexPath) as? SchoolTableViewCell
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        
        let college = schools[indexPath.row]
        
        cell?.schoolNameLabel.text = college.name
        cell?.commonAppLabel.text = college.ea
        cell?.deadlineLabel.text = college.rd
        
        return (cell)!
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Allows schools to be removed from the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            schools.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Segue for online users button.
    func userCountButtonDidTouch() {
        performSegue(withIdentifier: "OnlineUsers", sender: nil)
    }
    
    // Creates an unwind segue for the AddSchoolView Controller
    @IBAction func unwindToRootViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddSchoolViewController {
            let newSchool = sourceViewController.chosenSchool
            schools.append(newSchool!)
            tableView.reloadData()
        }
    }

    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    // Creates a segue that transfers the chosen school's information to the DetailsViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedSchool = schools[indexPath.row]
                let controller = segue.destination as! DetailsViewController
                controller.school = selectedSchool
            }
        }
    }
}
