//
//  AddSchoolViewController.swift
//  This code allows the user to see the details of a school they found using FindSchoolTableViewController and choose whether or not to add it to their School list or to cancel.
//
//  Created by Sofia Stanescu-Bellu on 2/17/17.
//
//

import UIKit

class AddSchoolViewController: UIViewController {
    
    var chosenSchool: School?

    // The features of the AddSchoolViewController
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var eaLabel: UILabel!
    @IBOutlet weak var edLabel: UILabel!
    @IBOutlet weak var rdLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var recsLabel: UILabel!
    @IBOutlet weak var schoolRLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var commonAppLabel: UILabel!
    @IBOutlet weak var suppLabel: UILabel!
    
    
    // Sets the text of the labels in this controller to the corresponding value in the School object.
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = chosenSchool?.name
        eaLabel.text = chosenSchool?.ea
        edLabel.text = chosenSchool?.ed
        rdLabel.text = chosenSchool?.rd
        mailLabel.text = chosenSchool?.mail
        onlineLabel.text = chosenSchool?.online
        recsLabel.text = chosenSchool?.rec
        schoolRLabel.text = chosenSchool?.schoolR
        midLabel.text = chosenSchool?.mid
        commonAppLabel.text = chosenSchool?.commonapp
        suppLabel.text = chosenSchool?.supp
        
        // Makes the navbar title the AppsTracker logo.
        let logo = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = UIViewContentMode.center
        self.navigationItem.titleView = imageView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Dismisses the view if the user taps cancel.
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
