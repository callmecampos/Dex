//
//  Connection.swift
//  Dex
//
//  Created by Felipe Campos on 12/20/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation

enum ConnectionType {
    case personal
    case mutual
}

internal class Connection {
    
    // MARK: Properties
    
    private var _users: [String : User] = [:]
    private var _type: ConnectionType
    private var _distance: Double = -1
    
    private static let first = "USER1"
    private static let second = "USER2"
 
    // MARK: Initialization
    
    init(user1: User, user2: User, distance: Double) {
        _users.updateValue(user1, forKey: Connection.first)
        _users.updateValue(user2, forKey: Connection.second)
        _distance = distance
        
        _type = (distance <= 1) ? ConnectionType.personal : ConnectionType.mutual
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
    
    func type() -> ConnectionType {
        return _type
    }
    
    func distance() -> Double {
        return _distance
    }
}
