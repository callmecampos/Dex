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
    private var description: String?
    private var email: String?
    private var phones: [String] = []
    private var website: String?
    private var avi: UIImage?
    
    // MARK: Methods
    
    init(name: String, desc: String, emails: String, phones: String..., web: String, avi: UIImage) {
        self.name = name
        self.description = desc
        self.website = web
        self.avi = avi
        
        for phone in phones {
            self.phones.append(phone)
        }
    }
    
    func getName() -> String? {
        return name
    }
    
    func setName(name: String) -> Bool {
        let n = self.getName()
        self.name = name
        return n != nil && n! == name
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func setDescription(desc: String) -> Bool {
        let d = getDescription()
        self.description = desc
        return d != nil && d! == desc
    }
    
    func getEmail() -> String? {
        return email
    }
    
    func setEmail(email: String) -> Bool {
        let e = getEmail()
        self.email = email
        return e != nil && e! == email
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
