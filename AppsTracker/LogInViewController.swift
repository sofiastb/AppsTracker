//
//  LogInViewController.swift
//  This code creates a login view in which the app user has the option of logging in with an existing user account, or to sign up with a new email and password. Uses Firebase's Authentication system to store the user data.
//  AppsTracker
//
//  Created by Sofia Stanescu-Bellu on 2/7/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    // MARK: Constraints
    let loginToList = "LoginToList"
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword:UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Makes the login and sign up buttons orund.
        loginButton.layer.cornerRadius = 5
        signInButton.layer.cornerRadius = 5
        
        // Checks to see if someone is logged in, if so, the app bypasses the login screen.
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
            }
        }
    }
    
    // MARK: Actions
    
    // Logs the user in with an existing account and email.
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!, password: textFieldLoginPassword.text!)
    }
    
    // Allows the user to sign up with an email and password. A notification bubble will pop up.
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        // Saves the user's inputted data
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            // creates the User in Firebase
            FIRAuth.auth()!.createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    FIRAuth.auth()!.signIn(withEmail: self.textFieldLoginEmail.text!, password: self.textFieldLoginPassword.text!)
                }
            }
        }
        
        // Allows the user to cancel the sign up process.
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        // Creates teh fields for the user to input their information.
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// An extension that checks if the login email and password are correct.
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
