//
//  LoginViewController.swift
//  Dex
//
//  Created by Felipe Campos on 1/25/18.
//  Copyright © 2018 Orange Inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var contactField: UITextField!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    var isPhone: Bool = false
    var savedPhone: Phone?
    
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
        if isPhone {
            let phoneNumber = contactField.text!
            savedPhone = Phone(number: phoneNumber, kind: .other)
            if let formatted = Utils.format(phoneNumber: phoneNumber) {
                contactField.text = formatted
            }
        }
        loginCheck()
    }
    
    
    @IBAction func editedPassword(_ sender: Any) {
        loginCheck()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        // FIXME: check user defaults for username and password and load corresponding data
        if isPhone {
            // FIXME: implement
        } else {
            Auth.auth().signIn(withEmail: contactField.text!, password: passwordField.text!, completion: { (user, error) in
                if user != nil {
                    // TODO: sign in successful, implement segue
                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                } else {
                    if let err = error?.localizedDescription {
                        print(err)
                    } else {
                        print("Undefined error.")
                    }
                }
            })
        }
    }
    
    // MARK: Methods
    
    func loginCheck() {
        if contactField.hasText && passwordField.hasText {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    func makeView() {
        logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Utils.hugeOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Utils.hugeOffset)
            make.width.equalTo(logoView.snp.height).multipliedBy(2.1 / 1.0)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(Utils.hugeOffset * 2)
            make.left.equalToSuperview().offset(Utils.mediumOffset)
            make.right.equalToSuperview().inset(Utils.mediumOffset)
            make.height.equalTo(contactLabel.font.lineHeight)
        }
        
        contactField.snp.makeConstraints { (make) in
            make.top.equalTo(contactLabel.snp.bottom).offset(Utils.smallOffset)
            make.left.equalToSuperview().offset(Utils.mediumOffset)
            make.right.equalToSuperview().inset(Utils.mediumOffset)
            make.height.equalTo(contactField.font!.lineHeight)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactField.snp.bottom).offset(Utils.hugeOffset * 2)
            make.left.equalToSuperview().offset(Utils.mediumOffset)
            make.right.equalToSuperview().inset(Utils.mediumOffset)
            make.height.equalTo(passwordLabel.font.lineHeight)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(Utils.smallOffset)
            make.left.equalToSuperview().offset(Utils.mediumOffset)
            make.right.equalToSuperview().inset(Utils.mediumOffset)
            make.height.equalTo(passwordField.font!.lineHeight)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(loginButton.snp.height).multipliedBy(19.0 / 15.0)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! ViewController
        vc.cards = [] // FIXME:
    }

}
