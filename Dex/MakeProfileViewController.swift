//
//  MakeProfileViewController.swift
//  Dex
//
//  Created by Felipe Campos on 12/29/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import UIKit

class MakeProfileViewController: UIViewController, SaveDelegate {
    
    // MARK: Properties
    
    @IBOutlet var completeProfileLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    var setupCardView: SetupCardView!
    var name: String = ""
    var profilePic: UIImage = UIImage()
    var isPhone: Bool = true
    var phone: Phone?
    var email: String?
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // FIXME: maybe perform in viewWillLayoutSubviews()
        
        nextButton.isHidden = true
        
        if isPhone {
            setupCardView = SetupCardView(name: name, phone: phone!, profilePic: profilePic)
        } else {
            setupCardView = SetupCardView(name: name, email: email!, profilePic: profilePic)
        }
        
        setupCardView.delegate = self
        
        makeView()
    }
    
    // MARK: Actions
    
    @IBAction func nextPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "profileComplete", sender: self)
    }
    
    
    // MARK: Methods
    
    func makeView() {
        completeProfileLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30) // offset from logo
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        setupCardView.snp.makeConstraints { (make) in
            make.top.equalTo(completeProfileLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(nextButton.snp.top)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }
    
    // MARK: Protocols
    
    func saveButtonTapped() {
        if setupCardView.occupation() == "" {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.left
            let messageText = NSMutableAttributedString(
                string: "\nWhoops! Looks like your occupation is missing, please fill it in before saving and continuing.",
                attributes: [
                    NSParagraphStyleAttributeName: paragraphStyle,
                    NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote),
                    NSForegroundColorAttributeName : UIColor.black
                ]
            )
            let titleStyle = NSMutableParagraphStyle()
            titleStyle.alignment = NSTextAlignment.center
            let titleText = NSMutableAttributedString(
                string: "Occupation Field Missing",
                attributes: [
                    NSParagraphStyleAttributeName: titleStyle,
                    NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline),
                    NSForegroundColorAttributeName : UIColor.black
                ]
            )
            let occupationFieldAlert = UIAlertController()
            occupationFieldAlert.setValue(titleText, forKey: "attributedTitle")
            occupationFieldAlert.setValue(messageText, forKey: "attributedMessage")
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            occupationFieldAlert.addAction(okAction)
            DispatchQueue.main.async {
                self.present(occupationFieldAlert, animated: true, completion:  nil)
            }
        }
        
        if isPhone {
            if setupCardView.hasPhone() {
                setupCardView.setSavedPhone(new: setupCardView.phone().number())
            } else {
                setupCardView.setSavedPhone(new: "")
            }
        } else {
            if setupCardView.hasEmail() {
                setupCardView.setSavedEmail(new: setupCardView.email())
            } else {
                setupCardView.setSavedEmail(new: "")
            }
        }
        
        if setupCardView.hasWebsite() {
            setupCardView.setSavedWebsite(new: setupCardView.website())
        } else {
            setupCardView.setSavedWebsite(new: "")
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! ViewController
        let user = User(name: name, interests: [])
        var card: Card
        if isPhone {
            var setupEmail = ""
            if setupCardView.hasEmail() {
                setupEmail = setupCardView.email()
            }
            if setupCardView.hasWebsite() {
                card = Card(user: user, occupation: setupCardView.occupation(), email: setupEmail, phones: [phone!], web: setupCardView.website(), avi: profilePic)
            } else {
                card = Card(user: user, occupation: setupCardView.occupation(), email: setupEmail, phones: [phone!], avi: profilePic)
            }
        } else {
            var phones: [Phone] = []
            if setupCardView.hasPhone() {
                phones.append(setupCardView.phone())
            }
            if setupCardView.hasWebsite() {
                card = Card(user: user, occupation: setupCardView.occupation(), email: email!, phones: phones, web: setupCardView.website(), avi: profilePic)
            } else {
                card = Card(user: user, occupation: setupCardView.occupation(), email: email!, phones: phones, avi: profilePic)
            }
        }
        
        vc.cards = [card]
    }
}
