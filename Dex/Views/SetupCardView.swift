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
    
    private var _isPhone: Bool = false
    
    private var _emailLabel: UILabel?
    private var _phoneLabel: UILabel?
    
    private var _emailFieldTitle: UILabel?
    private var _emailField: UITextField?
    private var _savedEmail: String = ""
    private var _phoneFieldTitle: UILabel?
    private var _phoneField: UITextField?
    private var _savedPhone: String = ""
    
    private var _saveButton: UIButton = UIButton()
    
    weak var delegate: SaveDelegate?
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    // MARK: Initialization
    
    // TODO: makeView for email / phone sign up
    
    convenience init(name: String, phone: Phone, profilePic: UIImage) {
        self.init(name: name, profilePic: profilePic, frame: CGRect.zero)
        makeView(phone: phone)
        _isPhone = true
    }
    
    convenience init(name: String, email: String, profilePic: UIImage) {
        self.init(name: name, profilePic: profilePic, frame: CGRect.zero)
        makeView(email: email)
        _isPhone = false
    }
    
    init(name: String, profilePic: UIImage, frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        _name.text = name
        _profilePicture = profilePic
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
        reviewSave()
    }
    
    func contactFieldEdited(_ sender: UITextField) {
        reviewSave()
    }
    
    func websiteFieldEdited(_ sender: UITextField) {
        reviewSave()
    }
    
    // MARK: Methods
    
    func reviewSave() {
        if hasOccupation() {
            if changedSinceLastSave() {
                _saveButton.isHidden = false
            } else {
                _saveButton.isHidden = true
            }
        }
    }
    
    func changedSinceLastSave() -> Bool {
        var changed: Bool = false
        if _isPhone {
            changed = email() == _savedEmail
        } else {
            changed = phone().number() == _savedPhone
        }
        
        return changed || occupation() != _savedOccupation || website() == _savedWebsite
    }
    
    func hasOccupation() -> Bool {
        return _occupationField.text! != ""
    }
    
    func occupation() -> String {
        return _occupationField.text!
    }
    
    func setSavedOccupation(new: String) {
        _savedOccupation = new
    }
    
    func hasWebsite() -> Bool {
        return _websiteField.text! != ""
    }
    
    func website() -> String {
        return _websiteField.text!
    }
    
    func setSavedWebsite(new: String) {
        _savedWebsite = new
    }
    
    func hasEmail() -> Bool {
        return _emailField!.text! != ""
    }
    
    func email() -> String {
        return _emailField!.text!
    }
    
    func setSavedEmail(new: String) {
        _savedEmail = new
    }
    
    func hasPhone() -> Bool {
        return _phoneField!.text! != ""
    }
    
    func phone() -> Phone {
        return Phone(number: _phoneField!.text!, kind: .other)
    }
    
    func setSavedPhone(new: String) {
        _savedPhone = new
    }
    
    private func makeView(phone: Phone) {
        makeView(phone: phone, email: nil)
    }
    
    private func makeView(email: String) {
        makeView(phone: nil, email: email)
    }
    
    private func makeView(phone: Phone?, email: String?) {
        // TODO: setup for multiple lines
        self.addSubview(_name)
        _name.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(5)
        }
        
        _imageView.image = _profilePicture
        _imageView.layer.cornerRadius = _imageView.frame.size.width / 2
        _imageView.layer.masksToBounds = true
        self.addSubview(_imageView)
        _imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5)
            make.left.greaterThanOrEqualTo(_name.snp.right).offset(5)
        }
        
        if phone != nil {
            _phoneLabel = UILabel()
            _phoneLabel!.text = phone!.number()
            self.addSubview(_phoneLabel!)
            _phoneLabel!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_name.snp.bottom).offset(5)
                make.left.equalTo(self).offset(5)
            }
        } else {
            _emailLabel = UILabel()
            _emailLabel!.text = email!
            self.addSubview(_emailLabel!)
            _emailLabel!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(_name.snp.bottom).offset(5)
                make.left.equalTo(self).offset(5)
            }
        }
        
        _occupationField.addTarget(self, action: #selector(occupationEdited(_:)), for: .editingDidEnd)
        self.addSubview(_occupationFieldTitle)
        self.addSubview(_occupationField)
        _occupationFieldTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_phoneLabel!.snp.bottom).offset(10)
            make.left.equalTo(self).offset(5)
        }
        _occupationField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_occupationFieldTitle.snp.bottom).offset(2.5)
            make.left.equalTo(self).offset(5)
        }
        
        self.addSubview(_emailFieldTitle!)
        self.addSubview(_emailField!)
        _emailFieldTitle!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_occupationField.snp.bottom).offset(5)
            make.left.equalTo(self).offset(5)
        }
        _emailField!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_emailFieldTitle!.snp.bottom).offset(2.5)
            make.left.equalTo(self).offset(5)
        }
        
        self.addSubview(_websiteFieldTitle)
        self.addSubview(_websiteField)
        _websiteFieldTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_emailField!.snp.bottom).offset(5)
            make.left.equalTo(self).offset(5)
        }
        _websiteField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_websiteFieldTitle.snp.bottom).offset(2.5)
            make.left.equalTo(self).offset(5)
        }
        
        _saveButton.setTitle("Save", for: .normal)
        _saveButton.backgroundColor = .red
        _saveButton.isHidden = true
        _saveButton.addTarget(self, action: #selector(self.saveTapped(_:)), for: .touchUpInside)
        self.addSubview(_saveButton)
        _saveButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_websiteField.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        makeTextField(textField: _occupationField, example: "Developer, Photographer, etc.")
        if phone != nil {
            makeTextField(textField: _emailField!, example: "chris@dex.com")
        } else {
            makeTextField(textField: _phoneField!, example: "(415) 555-5555")
        }
        makeTextField(textField: _websiteField, example: "www.dex.com")
    }
    
    private func makeTextField(textField: UITextField, example: String) { // check if UITextField is subpointer
        textField.placeholder = "e.g. \(example)"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.delegate = self
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
