//
//  CardView.swift
//  Dex
//
//  Created by Felipe Campos on 12/19/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import UIKit
import SnapKit
import Shiny

/** A card view class. */
@IBDesignable
class CardView: UIView {
    
    // MARK: Properties
    
    private var _card: Card
    private var _name: UILabel = UILabel()
    private var _occupation: UILabel = UILabel()
    private var _email: UILabel?
    private var _phone: UILabel?
    private var _website: UILabel?
    private var _profilePicture: UIImage?
    private var _imageView: UIImageView = UIImageView()
    
    private var _editButton: UIButton = UIButton()
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    // MARK: Initialization
    
    convenience init(card: Card) {
        self.init(card: card, frame: CGRect.zero)
    }
    
    init(card: Card, frame: CGRect) {
        _card = card
        super.init(frame: frame)
        makeView(card: card, frame: frame)
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
    
    // MARK: Methods
    
    /** Returns this view's card. */
    func card() -> Card {
        return _card
    }
    
    /** Makes the CardView given CARD and FRAME. */
    func makeView(card: Card, frame: CGRect) {
        _name.text = card.name()
        self.addSubview(_name)
        
        _name.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(5)
        }
        
        var topTarget: ConstraintItem = _name.snp.bottom
        
        _occupation.text = card.occupation()
        self.addSubview(_occupation)
        
        _occupation.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(topTarget).offset(10)
            make.left.equalTo(self).offset(5)
        }
        
        topTarget = _occupation.snp.bottom
        
        if card.hasPhoneNumbers() {
            _phone = UILabel()
            _phone!.text = card.primaryPhone().number()
            
            _phone!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(topTarget).offset(10)
                make.left.equalTo(self).offset(5)
            }
            
            topTarget = _phone!.snp.bottom
            
            /*
             var text: String = ""
             for phone in card.phones() {
                text.append(phone.number() + "(\(phone.type()))\n")
             }
             text.remove(at: text.endIndex)
             _phones!.text = text
             */
        }
        
        if card.hasEmail() {
            _email = UILabel()
            _email!.text = card.email()
            
            _email!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(topTarget).offset(5)
                make.left.equalTo(self).offset(5)
            }
            
            topTarget = _email!.snp.bottom
        }
        
        if card.hasWebsite() {
            _website = UILabel()
            _website!.text = card.website()
            
            _website!.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(topTarget).offset(5)
                make.left.equalTo(self).offset(5)
            }
            
            topTarget = _website!.snp.bottom
        }
        
        if card.hasProfilePicture() {
            _profilePicture = UIImage(cgImage: card.profilePicture())
            _imageView.image = _profilePicture!
        }
        _imageView.layer.cornerRadius = _imageView.frame.size.width / 2
        _imageView.layer.masksToBounds = true
        self.addSubview(_imageView)
        
        _imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5)
            make.right.equalTo(self).offset(5)
            make.left.greaterThanOrEqualTo(_name.snp.right)
        }
        
        _editButton.backgroundColor = UIColor.clear
        _editButton.tintColor = UIColor.blue
        _editButton.setTitle("Edit", for: .normal)
        _editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        self.addSubview(_editButton)
        
        _editButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(5)
            make.right.equalTo(self).offset(5)
        }
        
        /*
        
        let shinyView = ShinyView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
        shinyView.colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray]
        shinyView.locations = [0, 0.1, 0.2, 0.3, 1] // FIXME: test locations
        shinyView.startUpdates() // necessary
        self.addSubview(shinyView) // make shiny
        
        */
    }
    
    func editAction(sender: UIButton!) {
        // TODO: show pop-up view that edits card properties
        print("Editing")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
