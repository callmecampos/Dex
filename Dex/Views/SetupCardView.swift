//
//  SetupCardView.swift
//  Dex
//
//  Created by Felipe Campos on 12/30/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import UIKit
import SnapKit

protocol SaveDelegate: class {
    func saveButtonTapped()
}

class SetupCardView: UIView, UITextFieldDelegate {
    
    // MARK: Properties
    
    private var _name: UILabel = UILabel()
    private var _profilePicture: UIImage = UIImage()
    private var _imageView: UIImageView = UIImageView()
    private var _occupationFieldTitle: UILabel = UILabel()
    private var _occupationField: UITextField = UITextField()
    private var _savedOccupation: String = ""
    private var _websiteFieldTitle: UILabel = UILabel()
    private var _websiteField: UITextField = UITextField()
    private var _savedWebsite: String = ""
    
    private var _phoneGiven: Bool = false
    private var _givenPhone: Phone?
    private var _givenEmail: String?
    
    private var _emailLabel: UILabel?
    private var _phoneLabel: UILabel?
    
    private var _emailFieldTitle: UILabel?
    private var _emailField: UITextField?
    private var _savedEmail: String = ""
    private var _phoneFieldTitle: UILabel?
    private var _phoneField: UITextField?
    private var _savedPhone: String = ""
    
    private var _saveButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    weak var delegate: SaveDelegate?
    weak var textFieldDelegate: UITextFieldDelegate?
    
    private static let smallOffset = 5
    private static let mediumOffset = 10
    private static let largeOffset = 20
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    // MARK: Initialization
    
    // TODO: makeView for email / phone sign up
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 250, height: 500)
    }
    
    convenience init(name: String, phone: Phone, profilePic: UIImage) {
        self.init(name: name, profilePic: profilePic, frame: CGRect.zero)
        _givenPhone = phone
        _phoneGiven = true
        _phoneLabel = UILabel()
        _phoneLabel!.text = phone.number()
        self.addSubview(_phoneLabel!)
        
        _emailFieldTitle = UILabel()
        _emailField = UITextField()
        _emailFieldTitle!.text = "Email"
        self.addSubview(_emailFieldTitle!)
        self.addSubview(_emailField!)
    }
    
    convenience init(name: String, email: String, profilePic: UIImage) {
        self.init(name: name, profilePic: profilePic, frame: CGRect.zero)
        _givenEmail = email
        _phoneGiven = false
        _emailLabel = UILabel()
        _emailLabel!.text = email
        self.addSubview(_emailLabel!)
        
        _phoneFieldTitle = UILabel()
        _phoneField = UITextField()
        _phoneFieldTitle!.text = "Phone #"
        self.addSubview(_phoneFieldTitle!)
        self.addSubview(_phoneField!)
    }
    
    init(name: String, profilePic: UIImage, frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        _name.text = name
        _profilePicture = profilePic
        self.addSubview(_name)
        
        _imageView.image = _profilePicture
        _imageView.layer.cornerRadius = _imageView.frame.size.width / 2
        _imageView.layer.masksToBounds = true
        self.addSubview(_imageView)
        
        _occupationFieldTitle.text = "Occupation (*)" // TODO: caps
        _occupationField.addTarget(self, action: #selector(occupationEdited(_:)), for: .editingDidEnd)
        self.addSubview(_occupationFieldTitle)
        self.addSubview(_occupationField)
        
        _websiteFieldTitle.text = "Website" // TODO: caps
        self.addSubview(_websiteFieldTitle)
        self.addSubview(_websiteField)
        
        // TODO: aspect ratio?
        _saveButton.setTitle("Save", for: .normal)
        _saveButton.backgroundColor = .red
        _saveButton.isHidden = true
        _saveButton.addTarget(self, action: #selector(self.saveTapped(_:)), for: .touchUpInside)
        self.addSubview(_saveButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    // MARK: Actions
    
    func saveTapped(_ button: UIButton) {
        self.delegate?.saveButtonTapped()
    }
    
    func occupationEdited(_ sender: UITextField) {
        if hasOccupation() {
            _saveButton.isHidden = false
        } else {
            _saveButton.isHidden = true
        }
    }
    
    func contactFieldEdited(_ sender: UITextField) {
        if _phoneGiven {
            // check if email is valid (regex) -> set text field color to red if invalid
        } else {
            // check if phone number is valid (regex) -> set text field color to red if invalid
        }
    }
    
    func websiteFieldEdited(_ sender: UITextField) {
        // check if website is valid (regex) -> set text field color to red if invalid
    }
    
    // MARK: Methods
    
    func changedSinceLastSave() -> Bool {
        var changed: Bool = false
        if _phoneGiven {
            changed = email() == _savedEmail
        } else {
            changed = phone().number() == _savedPhone
        }
        
        return changed || occupation() != _savedOccupation || website() == _savedWebsite
    }
    
    func hasOccupation() -> Bool {
        return _occupationField.hasText
    }
    
    func occupation() -> String {
        return _occupationField.text!
    }
    
    func setSavedOccupation(new: String) {
        _savedOccupation = new
    }
    
    func hasWebsite() -> Bool {
        return _websiteField.hasText // FIXME: regex for validity
    }
    
    func website() -> String {
        return _websiteField.text!
    }
    
    func setSavedWebsite(new: String) {
        _savedWebsite = new
    }
    
    func hasEmail() -> Bool {
        return _emailField!.hasText // FIXME: regex for validity
    }
    
    func email() -> String {
        return _emailField!.text!
    }
    
    func setSavedEmail(new: String) {
        _savedEmail = new
    }
    
    func hasPhone() -> Bool {
        return _phoneField!.hasText // FIXME: regex for validity
    }
    
    func phone() -> Phone {
        return Phone(number: _phoneField!.text!, kind: .other)
    }
    
    func setSavedPhone(new: String) {
        _savedPhone = new
    }
    
    func makeView() {
        if _phoneGiven {
            makeView(phone: _givenPhone!)
        } else {
            makeView(email: _givenEmail!)
        }
    }
    
    private func makeView(phone: Phone) {
        makeView(phone: phone, email: nil)
    }
    
    private func makeView(email: String) {
        makeView(phone: nil, email: email)
    }
    
    private func makeView(phone: Phone?, email: String?) {
        // TODO: setup for multiple lines
        
        _name.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(SetupCardView.mediumOffset)
            make.left.equalTo(self).offset(SetupCardView.mediumOffset)
            make.right.lessThanOrEqualTo(_imageView.snp.left).inset(SetupCardView.smallOffset)
            make.height.equalTo(_name.font.lineHeight)
        }
        
        _name.sizeToFit()
        
        var topConstraint: ConstraintItem
        var contactLabelHeight: CGFloat
        if phone != nil {
            _phoneLabel!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_name.snp.bottom).offset(SetupCardView.mediumOffset)
                make.left.equalTo(self).offset(SetupCardView.mediumOffset)
                make.right.equalTo(self).inset(SetupCardView.mediumOffset)
                make.height.equalTo(_phoneLabel!.font.lineHeight)
            }
            topConstraint = _phoneLabel!.snp.bottom
            contactLabelHeight = _phoneLabel!.font.lineHeight
        } else {
            _emailLabel!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_name.snp.bottom).offset(SetupCardView.mediumOffset)
                make.left.equalTo(self).offset(SetupCardView.mediumOffset)
                make.right.equalTo(self).inset(SetupCardView.mediumOffset)
                make.height.equalTo(_emailLabel!.font.lineHeight)
            }
            topConstraint = _emailLabel!.snp.bottom
            contactLabelHeight = _emailLabel!.font.lineHeight
        }
        
        _imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(SetupCardView.mediumOffset)
            make.left.greaterThanOrEqualTo(_name.snp.right).offset(SetupCardView.smallOffset)
            make.width.equalTo(_name.font.lineHeight + CGFloat(SetupCardView.mediumOffset) + contactLabelHeight)
            make.right.equalTo(self).inset(SetupCardView.mediumOffset)
            make.bottom.equalTo(topConstraint)
        }
        
        _occupationFieldTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(topConstraint).offset(SetupCardView.largeOffset)
            make.left.equalTo(self).offset(SetupCardView.mediumOffset)
            make.right.equalTo(self).inset(SetupCardView.mediumOffset)
            make.height.equalTo(_occupationFieldTitle.font.lineHeight)
        }
        _occupationField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_occupationFieldTitle.snp.bottom).offset(SetupCardView.smallOffset)
            make.left.equalTo(self).offset(SetupCardView.mediumOffset)
            make.right.equalTo(self).inset(SetupCardView.mediumOffset)
            make.height.equalTo(_occupationField.font!.lineHeight)
        }
        
        if phone == nil {
            _phoneFieldTitle!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_occupationField.snp.bottom).offset(SetupCardView.mediumOffset)
                make.left.equalTo(self).offset(SetupCardView.mediumOffset)
                make.right.equalTo(self).inset(SetupCardView.mediumOffset)
                make.height.equalTo(_phoneFieldTitle!.font.lineHeight)
            }
            _phoneField!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_phoneFieldTitle!.snp.bottom).offset(SetupCardView.smallOffset)
                make.left.equalTo(self).offset(SetupCardView.mediumOffset)
                make.right.equalTo(self).inset(SetupCardView.mediumOffset)
                make.height.equalTo(_phoneField!.font!.lineHeight)
            }
            topConstraint = _phoneField!.snp.bottom
        } else {
            _emailFieldTitle!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_occupationField.snp.bottom).offset(SetupCardView.mediumOffset)
                make.left.equalTo(self).offset(SetupCardView.mediumOffset)
                make.right.equalTo(self).inset(SetupCardView.mediumOffset)
                make.height.equalTo(_emailFieldTitle!.font.lineHeight)
            }
            _emailField!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_emailFieldTitle!.snp.bottom).offset(SetupCardView.smallOffset)
                make.left.equalTo(self).offset(SetupCardView.mediumOffset)
                make.right.equalTo(self).inset(SetupCardView.mediumOffset)
                make.height.equalTo(_emailField!.font!.lineHeight)
            }
            topConstraint = _emailField!.snp.bottom
        }
        
        _websiteFieldTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(topConstraint).offset(SetupCardView.mediumOffset)
            make.left.equalTo(self).offset(SetupCardView.mediumOffset)
            make.right.equalTo(self).inset(SetupCardView.mediumOffset)
            make.height.equalTo(_websiteFieldTitle.font.lineHeight)
        }
        _websiteField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_websiteFieldTitle.snp.bottom).offset(SetupCardView.smallOffset)
            make.left.equalTo(self).offset(SetupCardView.mediumOffset)
            make.right.equalTo(self).inset(SetupCardView.mediumOffset)
            make.height.equalTo(_websiteField.font!.lineHeight)
        }
        
        _saveButton.snp.makeConstraints { (make) -> Void in
            make.top.greaterThanOrEqualTo(_websiteField.snp.bottom).offset(SetupCardView.largeOffset)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).inset(SetupCardView.largeOffset)
        }
        
        makeOccupationField(example: "Developer, Photographer, etc.")
        if phone != nil {
            makeEmailField(example: "chris@dex.com")
        } else {
            makePhoneField(example: "(415) 555-5555")
        }
        makeWebsiteField(example: "www.dex.com")
    }
    
    private func makeOccupationField(example: String) {
        _occupationField.placeholder = "e.g. \(example)"
        _occupationField.autocapitalizationType = .sentences
        _occupationField.font = UIFont.systemFont(ofSize: 15)
        _occupationField.borderStyle = UITextBorderStyle.roundedRect
        _occupationField.autocorrectionType = UITextAutocorrectionType.no
        _occupationField.keyboardType = UIKeyboardType.default
        _occupationField.returnKeyType = UIReturnKeyType.done
        _occupationField.clearButtonMode = UITextFieldViewMode.whileEditing
        _occupationField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        _occupationField.delegate = textFieldDelegate!
    }
    
    private func makePhoneField(example: String) {
        _phoneField!.placeholder = "e.g. \(example)"
        _phoneField!.font = UIFont.systemFont(ofSize: 15)
        _phoneField!.borderStyle = UITextBorderStyle.roundedRect
        _phoneField!.autocorrectionType = UITextAutocorrectionType.no
        _phoneField!.keyboardType = UIKeyboardType.phonePad
        _phoneField!.returnKeyType = UIReturnKeyType.done
        _phoneField!.clearButtonMode = UITextFieldViewMode.whileEditing
        _phoneField!.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        _phoneField!.delegate = textFieldDelegate!
    }
    
    private func makeEmailField(example: String) {
        _emailField!.placeholder = "e.g. \(example)"
        _emailField!.autocapitalizationType = .none
        _emailField!.font = UIFont.systemFont(ofSize: 15)
        _emailField!.borderStyle = UITextBorderStyle.roundedRect
        _emailField!.autocorrectionType = UITextAutocorrectionType.no
        _emailField!.keyboardType = UIKeyboardType.emailAddress
        _emailField!.returnKeyType = UIReturnKeyType.done
        _emailField!.clearButtonMode = UITextFieldViewMode.whileEditing
        _emailField!.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        _emailField!.delegate = textFieldDelegate!
    }
    
    private func makeWebsiteField(example: String) {
        _websiteField.placeholder = "e.g. \(example)"
        _websiteField.autocapitalizationType = .none
        _websiteField.font = UIFont.systemFont(ofSize: 15)
        _websiteField.borderStyle = UITextBorderStyle.roundedRect
        _websiteField.autocorrectionType = UITextAutocorrectionType.no
        _websiteField.keyboardType = UIKeyboardType.URL
        _websiteField.returnKeyType = UIReturnKeyType.done
        _websiteField.clearButtonMode = UITextFieldViewMode.whileEditing
        _websiteField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        _websiteField.delegate = textFieldDelegate!
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
