//
//  SignUpViewController.swift
//  Dex
//
//  Created by Felipe Campos on 1/10/18.
//  Copyright © 2018 Orange Inc. All rights reserved.
//

import UIKit // TODO: use Firebase to upload user information

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var contactPrompt: UILabel!
    @IBOutlet var contactField: UITextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var profilePicView: UIImageView!
    var isPhone: Bool = true
    let picker = UIImagePickerController()
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        nextButton.isHidden = true
        
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        if isPhone {
            contactPrompt.text = "What's your phone number?"
            contactField.placeholder = "(415) 555-5555"
        } else {
            contactPrompt.text = "What's your email?"
            contactField.placeholder = "chris@dex.com"
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectAvi(_ sender: Any) {
        picker.allowsEditing = true
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let messageText = NSMutableAttributedString(
            string: "How would you like to create your profile picture?",
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body),
                NSForegroundColorAttributeName : UIColor.black
            ]
        )
        let webAlert = UIAlertController()
        webAlert.setValue(messageText, forKey: "attributedMessage")
        
        let plAction = UIAlertAction(title: "Choose from Library", style: .default, handler: {(alert: UIAlertAction!) in
            // set to photo library
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        })
        
        let camAction = UIAlertAction(title: "Take a Photo", style: .default, handler: {(alert: UIAlertAction!) in
            // set to camera
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        })
        
        webAlert.addAction(plAction)
        webAlert.addAction(camAction)
        
        DispatchQueue.main.async {
            self.present(webAlert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.profilePicView.image = image
        if firstNameField.hasText && lastNameField.hasText && contactField.hasText {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstNameEdited(_ sender: Any) {
        if lastNameField.hasText && contactField.hasText && profilePicView.image != nil {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
    }
    
    @IBAction func lastNameEdited(_ sender: Any) {
        if firstNameField.hasText && contactField.hasText && profilePicView.image != nil {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
    }
    
    @IBAction func contactFieldEdited(_ sender: Any) {
        if firstNameField.hasText && firstNameField.hasText && profilePicView.image != nil {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! MakeProfileViewController
        vc.profilePic = profilePicView.image!
        vc.name = firstNameField.text! + lastNameField.text!
        vc.isPhone = isPhone
        if isPhone {
            vc.phone = Phone(number: contactField.text!, kind: .other)
        } else {
            vc.email = contactField.text!
        }
        vc.profilePic = self.profilePicView.image!
    }

}
