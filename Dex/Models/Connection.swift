//
//  Connection.swift
//  Dex
//
//  Created by Felipe Campos on 12/20/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation

internal class Connection: Equatable, Comparable, Hashable {
    
    enum Form {
        case personal
        case recommended
        case weak
        case other
    }
    
    // MARK: Properties
    
    private var _users: [String : User] = [:]
    private var _type: Form
    private var _distance: Double = -1.0
    
    private static let first = "USER1"
    private static let second = "USER2"
 
    // MARK: Initialization
    
    init(user1: User, user2: User, form: Connection.Form) {
        _users.updateValue(user1, forKey: Connection.first)
        _users.updateValue(user2, forKey: Connection.second)
        
        switch form {
        case .personal:
            _distance = 1
            break
        case .recommended:
            _distance = 2
            break
        case .weak:
            _distance = 3
            break
        default:
            _distance = Double.infinity
            break
        }
        
        _type = form
    }
    
    // MARK: Methods
    
    func getConnection(this: User) -> User? {
        if !users().values.contains(this) {
            return nil
        }
        
        let key = (users() as NSDictionary).allKeys(for: this) as! [String]
        if key[0] == Connection.first {
            return getUser(id: Connection.second)
        } else {
            return getUser(id: Connection.first)
        }
    }
    
    func users() -> [String : User] {
        return _users
    }
    
    func getUser(id: String) -> User? {
        return users()[id]
    }
    
    func type() -> Form {
        return _type
    }
    
    func distance() -> Double {
        return _distance
    }
    
    // MARK: Protocols
    
    static func ==(lhs: Connection, rhs: Connection) -> Bool {
        return lhs.type() == rhs.type() && lhs.distance() == rhs.distance() &&
                lhs.users() == rhs.users()
    }
    
    static func <(lhs: Connection, rhs: Connection) -> Bool {
        return lhs.distance() < rhs.distance()
    }
    
    /** Combines the hash value of each property multiplied by a prime constant. */
    var hashValue: Int {
        var hash = distance().hashValue
        hash ^= type().hashValue
        for user in users() {
            hash ^= user.value.hashValue
        }
        
        return hash &* Utils.HASH_PRIME
    }
}
