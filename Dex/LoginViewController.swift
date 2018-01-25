//
//  LoginViewController.swift
//  Dex
//
//  Created by Felipe Campos on 1/25/18.
//  Copyright © 2018 Orange Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var contactField: UITextField!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    var isPhone: Bool = false
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        contactField.delegate = self
        passwordField.delegate = self
        
        hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
        if isPhone {
            contactLabel.text = "Phone Number:"
            contactField.placeholder = "(415) 555-5555"
            contactField.keyboardType = .phonePad
            contactLabel.sizeToFit()
        } else {
            contactLabel.text = "Email:"
            contactField.placeholder = "chris@dex.com"
            contactField.keyboardType = .emailAddress
        }
    }
    
    // MARK: Actions
    
    @IBAction func editedContact(_ sender: Any) {
        loginCheck()
    }
    
    
    @IBAction func editedPassword(_ sender: Any) {
        loginCheck()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        // FIXME: check user defaults for username and password and load corresponding data
    }
    
    // MARK: Methods
    
    func loginCheck() {
        if contactField.hasText && passwordField.hasText {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
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
