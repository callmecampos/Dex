//
//  Card.swift
//  Dex
//
//  Created by Felipe Campos on 12/18/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation
import UIKit

public class Card {
    
    // MARK: Properties
    
    private var name: String?
    private var origin: String?
    private var description: String?
    private var email: String?
    private var phones: [String] = []
    private var website: String?
    private var avi: UIImage?
    
    // MARK: Initialization
    
    init(name: String, loc: String, desc: String, email: String, phones: String..., web: String, avi: UIImage) {
        self.name = name
        self.origin = loc
        self.description = desc
        self.email = email
        self.website = web
        self.avi = avi
        
        for phone in phones {
            self.phones.append(phone)
        }
    }
    
    // MARK: Methods
    
    func getName() -> String? {
        return name
    }
    
    func setName(name: String) -> Bool {
        let n = self.getName()
        self.name = name
        return n != nil && n! == name
    }
    
    func getOrigin() -> String? {
        return origin
    }
    
    func setOrigin(loc: String) -> Bool {
        let o = getOrigin()
        if o != nil {
            self.origin = loc
            return o! == loc
        }
        
        return false
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func setDescription(desc: String) -> Bool {
        let d = getDescription()
        if d != nil {
            self.description = desc
            return d! == desc
        }
        
        return false
    }
    
    func getEmail() -> String? {
        return email
    }
    
    func setEmail(email: String) -> Bool {
        let e = getEmail()
        if e != nil {
            self.email = email
            return e! == email
        }
        
        return false
    }
    
    func getPhoneNumbers() -> [String] {
        return phones
    }
    
    func addPhone(phone: String) -> Bool {
        if phones.contains(phone) || validPhone(phone: phone) {
            phones.append(phone)
            return true
        }
        
        return false
    }
    
    func removePhone(phone: String) -> Bool {
        if phones.contains(phone) {
            let ind = phones.index(of: phone)
            phones.remove(at: ind!)
            return true
        }
        
        return false
    }
    
    func validPhone(phone: String) -> Bool {
        return true // FIXME
    }
    
    func getProfilePicture() -> UIImage? {
        return avi
    }
    
    func setProfilePicture(new: UIImage) {
        self.avi = new
    }
}
