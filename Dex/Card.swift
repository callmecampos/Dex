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
    
    private var name: String
    private var description: String?
    private var email: String?
    private var phones: [String] = []
    private var website: String?
    private var avi: UIImage?
    
    // MARK: Initialization
    
    init(name: String, loc: String, desc: String, email: String, phones: String..., web: String, avi: UIImage) {
        self.name = name
        self.description = desc
        self.email = email
        self.website = web
        self.avi = avi
        
        for phone in phones {
            self.phones.append(phone)
        }
    }
    
    // MARK: Methods
    
    /** Returns the name associated with this card. */
    func getName() -> String {
        return name
    }
    
    /** Sets the name for this card as NAME.
        Returns whether the contents were modified.
     */
    func setName(name: String) -> Bool {
        let n = self.getName()
        self.name = name
        return n != name
    }
    
    /** Returns the optional description associated with this card. */
    func getDescription() -> String? {
        return description
    }
    
    /** Sets the description for this card as DESC.
        Returns whether the contents were modified.
     */
    func setDescription(desc: String) -> Bool {
        let d = getDescription()
        self.description = desc
        return d == nil || d! != desc
    }
    
    /** Returns the optional email associated with this card. */
    func getEmail() -> String? {
        return email
    }
    
    /** Sets the email for this card as EMAIL.
        Returns whether the contents were modified.
     */
    func setEmail(email: String) -> Bool {
        let e = getEmail()
        self.email = email
        return e == nil || e! == email
    }
    
    /** Returns the optional website associated with this card. */
    func getWebsite() -> String? {
        return website
    }
    
    /** Sets the website for this card, if valid.
        Returns whether the website was set.
     */
    func setWebsite(site: String) -> Bool {
        if validWebsite(site: site) {
            self.website = site
            return true
        }
        
        return false
    }
    
    /** Returns whether SITE is a valid url. */
    func validWebsite(site: String) -> Bool {
        return true // FIXME: implement
    }
    
    /** Returns an array of the phone numbers associated with this card. */
    func getPhoneNumbers() -> [String] {
        return phones
    }
    
    /** Adds PHONE to the phones associated with this card, if valid.
        Returns whether the phone was successfully added
     */
    func addPhone(phone: String) -> Bool {
        if !phones.contains(phone) && validPhone(phone: phone) {
            phones.append(phone)
            return true
        }
        
        return false
    }
    
    /** Removes PHONE from the phones associated with this card.
        Returns whether the phone was successfully removed.
     */
    func removePhone(phone: String) -> Bool {
        if phones.contains(phone) {
            let ind = phones.index(of: phone)
            phones.remove(at: ind!)
            return true
        }
        
        return false
    }
    
    /** Returns whether PHONE is a valid number. */
    func validPhone(phone: String) -> Bool {
        return true // FIXME: implement
    }
    
    /** Returns the optional profile picture associated with this card. */
    func getProfilePicture() -> UIImage? {
        return avi
    }
    
    /** Sets the profile picture for this card.
        Returns whether the image contents changed.
     */
    func setProfilePicture(new: UIImage) -> Bool{
        let a = getProfilePicture()
        self.avi = new
        return a == nil || a! == new
    }
    
    // MARK: Protocols
    
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        if lhs.getPhoneNumbers().count != rhs.getPhoneNumbers().count {
            return false
        }
        
        for phone in lhs.getPhoneNumbers() {
            if !rhs.getPhoneNumbers().contains(phone) {
                return false
            }
        }
        
        return lhs.getName() == rhs.getName() &&
            lhs.getDescription() == rhs.getDescription() &&
            lhs.getEmail() == rhs.getEmail() &&
            lhs.getWebsite() == rhs.getWebsite() &&
            lhs.getProfilePicture() == rhs.getProfilePicture()
    }
    
    /** Combines the hash value of each non-nil property
     multiplied by a prime constant.
     */
    public var hashValue: Int {
        var hash = name.hashValue
        var count: Double = 0
        
        if let d = getDescription() {
            hash ^= d.hashValue
            count += 1
        }
        
        if let e = getEmail() {
            hash ^= e.hashValue
            count += 1
        }
        
        if phones.count > 0 {
            for phone in phones {
                hash ^= phone.hashValue
                count += 1
            }
        }
        
        if let w = getWebsite() {
            hash ^= w.hashValue
            count += 1
        }
        
        if let a = getProfilePicture() {
            hash ^= a.hashValue
            count += 1
        }
        
        return hash &* 16777619
    }
}
