//
//  CardView.swift
//  Dex
//
//  Created by Felipe Campos on 12/19/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    // MARK: Properties
    
    private var _card: Card
    private var _name: UILabel = UILabel()
    private var _description: UILabel?
    private var _email: UILabel?
    private var _phones: UILabel?
    private var _website: UILabel?
    private var _profilePicture: UIImage?
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    // MARK: Initialization
    
    init(card: Card, frame: CGRect) {
        _card = card
        super.init(frame: frame)
        makeView(card: card)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    // MARK: Methods
    
    /** Returns this view's card. */
    func card() -> Card {
        return _card
    }
    
    /** Makes the CardView given CARD. */
    func makeView(card: Card) {
        _name.text = card.name()
        
        if card.hasDescription() {
            _description = UILabel()
            _description!.text = card.description()
            // TODO: other UI setup
        }
        
        if card.hasEmail() {
            _email = UILabel()
            _email!.text = card.email()
            // TODO: other UI setup
        }
        
        if card.hasPhoneNumbers() {
            _phones = UILabel()
            var text: String = ""
            for phone in card.phoneNumbers() {
                text.append(phone + "\n")
            }
            text.remove(at: text.endIndex)
            _phones!.text = text
            // TODO: other UI setup
        }
        
        if card.hasWebsite() {
            _website = UILabel()
            _email!.text = card.website()
            // TODO: other UI setup
        }
        
        if card.hasProfilePicture() {
            _profilePicture = UIImage(cgImage: card.profilePicture())
            // TODO: other UI setup
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /*
    let shinyView = ShinyView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
    shinyView.colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray]
    shinyView.locations = [0, 0.1, 0.2, 0.3, 1]
    shinyView.startUpdates() // necessary
    view.addSubview(shinyView)
    */

}
