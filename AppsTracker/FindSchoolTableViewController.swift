//
//  FindSchoolTableViewController.swift
//  This code pulls up a list of the schools in the schools Firebase database 
//  and allows the user to see the details of each and potentially add them
//  to the SchoolTableViewController. The Firebase data was obtained by scraping
//  a website featuring all the infromation about the 600 colleges in my database.
//  AppsTracker
//
//  Created by Sofia Stanescu-Bellu on 2/5/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FindSchoolTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: Outlets
    @IBOutlet var findSchoolTableView: UITableView!
    
    // MARK: Constants
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Properties
    var schools: [School] = []
    var filteredSchools: [School] = []
    
    // Database reference
    var databaseRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creates a search controller to search the schools.
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        // Reference to Firebase Database
        let ref = FIRDatabase.database().reference().child("colleges")
        
        // Snapshot of the FireBase Data
        ref.observe(.value, with: { snapshot in
            // Had an issue where the snaphsot didn't exist so I added this if statement
            if snapshot.exists() {
                // Populates Members Array
                for school in snapshot.children {
                    let newSchool = School(snapshot: school as! FIRDataSnapshot)
                    self.schools.append(newSchool)
                }
                self.tableView.reloadData()
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredSchools.count
        }
        return schools.count
    }

    // Populates the SchoolFinderCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolFinderCell", for: indexPath)
        
        let school: School?
        
        if searchController.isActive && searchController.searchBar.text != "" {
            school = filteredSchools[indexPath.row]
        } else {
            school = schools[indexPath.row]
        }

        cell.textLabel?.text = school?.name
        cell.detailTextLabel?.text = school?.rd

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // Creates a segue that takes the chosen school's information and displays it in the AddSchoolViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSchool" {
            if let indexPath = tableView.indexPathForSelectedRow {
                var school = schools[indexPath.row]
                if searchController.isActive && searchController.searchBar.text != "" {
                    school = filteredSchools[indexPath.row]
                }
                let controller = segue.destination as? AddSchoolViewController
                controller?.chosenSchool = school
            }
        }
    }
    
    // Dismisses the FindSchoolTableViewController.
    @IBAction func dismissFindSchool(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    // The next two functions filter the user's search results based on their query.
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContent(searchText: self.searchController.searchBar.text!)
        
    }
    
    func filterContent(searchText: String) {
        self.filteredSchools = schools.filter { school in
            let college = school.name
            return(college.lowercased().contains(searchText.lowercased()))
        }
        tableView.reloadData()
    }
}
