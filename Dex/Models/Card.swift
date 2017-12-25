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
    
    private var _name: String
    private var _description: String?
    private var _email: String?
    private var _phones: [String] = []
    private var _website: String?
    private var _avi: CGImage?
    
    // MARK: Initialization
    
    init(name: String, loc: String, desc: String, email: String, phones: String..., web: String, avi: CGImage) {
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
        Returns whether the contents were modified.
     */
    func setEmail(email: String) -> Bool {
        let e = _email
        _email = email
        return e == nil || e! == email
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
        return true // FIXME: implement
    }
    
    /** Returns whether the card has any phone numbers. */
    func hasPhoneNumbers() -> Bool {
        return _phones.count > 0
    }
    
    /** Returns an array of the phone numbers associated with this card. */
    func phoneNumbers() -> [String] {
        return _phones
    }
    
    /** Adds PHONE to the phones associated with this card, if valid.
        Returns whether the phone was successfully added
     */
    func addPhone(phone: String) -> Bool {
        if !_phones.contains(phone) && validPhone(phone: phone) {
            _phones.append(phone)
            return true
        }
        
        return false
    }
    
    /** Removes PHONE from the phones associated with this card.
        Returns whether the phone was successfully removed.
     */
    func removePhone(phone: String) -> Bool {
        if _phones.contains(phone) {
            let ind = _phones.index(of: phone)
            _phones.remove(at: ind!)
            return true
        }
        
        return false
    }
    
    /** Returns whether PHONE is a valid number. */
    func validPhone(phone: String) -> Bool {
        return true // FIXME: implement
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
        if lhs.phoneNumbers().count != rhs.phoneNumbers().count {
            return false
        }
        
        for phone in lhs.phoneNumbers() {
            if !rhs.phoneNumbers().contains(phone) {
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
     multiplied by a prime constant.
     */
    public var hashValue: Int {
        var hash = _name.hashValue
        var count: Double = 0
        
        if let d = _description {
            hash ^= d.hashValue
            count += 1
        }
        
        if let e = _email {
            hash ^= e.hashValue
            count += 1
        }
        
        if _phones.count > 0 {
            for phone in _phones {
                hash ^= phone.hashValue
                count += 1
            }
        }
        
        if let w = _website {
            hash ^= w.hashValue
            count += 1
        }
        
        if let a = _avi {
            hash ^= a.hashValue
            count += 1
        }
        
        return hash &* 16777619
    }
}
