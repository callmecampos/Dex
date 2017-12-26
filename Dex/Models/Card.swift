//
//  Card.swift
//  Dex
//
//  Created by Felipe Campos on 12/18/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation
import UIKit

internal class Card: Equatable, Hashable {
    
    // MARK: Properties
    
    /** The card's user. */
    private var _user: User
    
    /** The card's name. */
    private var _name: String
    
    /** The card's description. */
    private var _description: String?
    
    /** The card's email. */
    private var _email: String?
    
    /** The card's phones. */
    private var _phones: [Phone] = []
    
    /** The card's website. */
    private var _website: String?
    
    /** The card's avi. */
    private var _avi: CGImage?
    
    // MARK: Initialization
    
    init(user: User, name: String, loc: String, desc: String,
         email: String, phones: Phone..., web: String, avi: CGImage) {
        _user = user
        _name = name
        _description = desc
        _email = email
        _website = web
        _avi = avi
        
        for phone in phones {
            _phones.append(phone)
        }
    }
    
    // MARK: Methods
    
    /** Returns the name associated with this card. */
    func name() -> String {
        return _name
    }
    
    /** Sets the name for this card as NAME.
        Returns whether the contents were modified.
     */
    func setName(name: String) -> Bool {
        let n = _name
        _name = name
        return n != name
    }
    
    /** Returns whether the card has a description. */
    func hasDescription() -> Bool {
        return _description != nil
    }
    
    /** Returns the optional description associated with this card. */
    func description() -> String {
        return _description!
    }
    
    /** Sets the description for this card as DESC.
        Returns whether the contents were modified.
     */
    func setDescription(desc: String) -> Bool {
        let d = _description
        _description = desc
        return d == nil || d! != desc
    }
    
    /** Returns whether the card has an email. */
    func hasEmail() -> Bool {
        return _email != nil
    }
    
    /** Returns the optional email associated with this card. */
    func email() -> String {
        return _email!
    }
    
    /** Sets the email for this card as EMAIL.
        Returns whether the email is valid.
     */
    func setEmail(email: String) -> Bool {
        if validEmail(email: email) {
            _email = email
            return true
        }
        
        return false
    }
    
    /** Returns whether EMAIL is a valid email. */
    func validEmail(email: String) -> Bool {
        return Utils.regex(pattern: Utils.EMAIL_REGEX, object: email)
    }
    
    /** Returns whether the card has a website. */
    func hasWebsite() -> Bool {
        return _website != nil
    }
    
    /** Returns the optional website associated with this card. */
    func website() -> String {
        return _website!
    }
    
    /** Sets the website for this card, if valid.
        Returns whether the website was set.
     */
    func setWebsite(site: String) -> Bool {
        if validWebsite(site: site) {
            _website = site
            return true
        }
        
        return false
    }
    
    /** Returns whether SITE is a valid url. */
    func validWebsite(site: String) -> Bool {
        return Utils.regex(pattern: Utils.WEB_REGEX, object: site)
    }
    
    /** Returns whether the card has any phone numbers. */
    func hasPhoneNumbers() -> Bool {
        return _phones.count > 0
    }
    
    /** Returns an array of the phone numbers associated with this card. */
    func phones() -> [Phone] {
        return _phones
    }
    
    /** Returns this card's primary phone. */
    func primaryPhone() -> Phone {
        return _phones[0]
    }
    
    /** Adds PHONE to the phones associated with this card, if valid.
        Returns whether the phone was successfully added
     */
    func addPhone(phone: Phone) -> Bool {
        if phone.isValid() && !_phones.contains(phone) {
            _phones.append(phone)
            return true
        }
        
        return false
    }
    
    /** Removes PHONE from the phones associated with this card.
        Returns whether the phone was successfully removed.
     */
    func removePhone(phone: Phone) -> Bool {
        if _phones.contains(phone) {
            let ind = _phones.index(of: phone)
            _phones.remove(at: ind!)
            return true
        }
        
        return false
    }
    
    /** Returns whether the card has a profile picture. */
    func hasProfilePicture() -> Bool {
        return _avi != nil
    }
    
    /** Returns the optional profile picture associated with this card. */
    func profilePicture() -> CGImage {
        return _avi!
    }
    
    /** Sets the profile picture as NEW for this card.
        Returns whether the image contents changed.
     */
    func setProfilePicture(new: CGImage) -> Bool {
        let a = _avi
        _avi = new
        return a == nil || a! == new
    }
    
    // MARK: Protocols
    
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        if lhs.phones().count != rhs.phones().count {
            return false
        }
        
        for phone in lhs.phones() {
            if !rhs.phones().contains(phone) {
                return false
            }
        }
        
        return lhs.name() == rhs.name() &&
            lhs.description() == rhs.description() &&
            lhs.email() == rhs.email() &&
            lhs.website() == rhs.website() &&
            lhs.profilePicture() == rhs.profilePicture()
    }
    
    /** Combines the hash value of each non-nil property
     multiplied by a prime constant. */
    public var hashValue: Int {
        var hash = _name.hashValue
        
        if let d = _description {
            hash ^= d.hashValue
        }
        
        if let e = _email {
            hash ^= e.hashValue
        }
        
        if _phones.count > 0 {
            for phone in _phones {
                hash ^= phone.hashValue
            }
        }
        
        if let w = _website {
            hash ^= w.hashValue
        }
        
        if let a = _avi {
            hash ^= a.hashValue
        }
        
        return hash &* Utils.HASH_PRIME
    }
}
