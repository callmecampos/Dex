//
//  SignUpViewController.swift
//  Dex
//
//  Created by Felipe Campos on 1/10/18.
//  Copyright © 2018 Orange Inc. All rights reserved.
//

import UIKit // TODO: use Firebase to upload user information
import Photos

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
    var cameraAuthorized: Bool = false
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        nextButton.isEnabled = false
        
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        if isPhone {
            contactPrompt.text = "What's your phone number?"
            contactField.placeholder = "(415) 555-5555"
            contactField.keyboardType = .phonePad
            contactPrompt.sizeToFit()
        } else {
            contactPrompt.text = "What's your email?"
            contactField.placeholder = "chris@dex.com"
            contactField.keyboardType = .emailAddress
        }
        
        checkCameraAuthorization()
    }
    
    // MARK: Actions
    
    @IBAction func nextPressed(_ sender: Any) {
        print("Pressed.")
        super.performSegue(withIdentifier: "initSignUpComplete", sender: self)
    }
    
    @IBAction func selectAvi(_ sender: Any) {
        if cameraAuthorized {
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
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if cameraAuthorized {
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                self.profilePicView.image = image
                if firstNameField.hasText && lastNameField.hasText && contactField.hasText {
                    nextButton.isEnabled = true
                } else {
                    nextButton.isEnabled = false
                }
            
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func firstNameEdited(_ sender: Any) {
        reviewNext()
    }
    
    @IBAction func lastNameEdited(_ sender: Any) {
        reviewNext()
    }
    
    @IBAction func contactFieldEdited(_ sender: Any) {
        reviewNext()
    }
    
    // MARK: Methods
    
    func reviewNext() {
        if firstNameField.hasText && lastNameField.hasText && contactField.hasText && profilePicView.image != nil {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func checkCameraAuthorization() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            cameraAuthorized = true
            print("Access granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("Auth status is \(newStatus)")
                if newStatus == PHAuthorizationStatus.authorized {
                    self.cameraAuthorized = true
                    print("success")
                }
            })
            print("Auth status not determined.")
        case .restricted:
            cameraAuthorized = false
            print("User does not have access to the photo album.")
        case .denied:
            cameraAuthorized = false
            print("User has denied permission.")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! MakeProfileViewController
        vc.profilePic = profilePicView.image!
        vc.name = firstNameField.text! + " " + lastNameField.text!
        vc.isPhone = isPhone
        if isPhone {
            vc.phone = Phone(number: contactField.text!, kind: .other)
        } else {
            vc.email = contactField.text!
        }
        vc.profilePic = self.profilePicView.image!
    }

}