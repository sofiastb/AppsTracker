//
//  DetailsViewController.swift
//  This code shows a to do list for each school in the user's school list. The user can delte to do list objects that are not relevant and check off those that have been completeed.
//  AppsTracker
//
//  Created by Sofia Stanescu-Bellu on 2/3/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Features of the DetailsViewController
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    var school: School?
    var toDo: [String?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds a table footer to remove unnecessary cells.
        toDoTableView.tableFooterView = UIView()
        
        // Makes the navbar title the AppsTracker logo.
        self.schoolNameLabel.text = school?.name
        let logo = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = UIViewContentMode.center
        self.navigationItem.titleView = imageView

        // Calls the function that populates the toDo list.
        toDoList()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Populates the toDo list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.textLabel?.text = toDo[indexPath.row]
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDo.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Allows the toDo list to be modified
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Allows users to add a check a toDo list cell as completed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.checkmark){
            cell!.accessoryType = UITableViewCellAccessoryType.none;
        } else{
            cell!.accessoryType = UITableViewCellAccessoryType.checkmark;
        }
    }

    // Allows schools to be removed from the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Fills the array that populates the toDo list
    func toDoList() {
        toDo = ["Early Action: " + (school?.ea)!, "Early Decision: " + (school?.ed)!, "Regular Decision: " + (school?.rd)!,
                 "Mail Fee: $" + (school?.mail)!, "Online Fee: $" + (school?.online)!, "Recommendation(s): " + (school?.rec)!,
                 "School Report: " + (school?.schoolR)!, "Midyear Report: " + (school?.mid)!, "Common App: " + (school?.commonapp)!,
                 "Supplement(s): " + (school?.supp)!]
    }
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// GRRect Extension to size the DALI logo in the navbar header.
extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
