//
//  User.swift
//  Dex
//
//  Created by Felipe Campos on 12/19/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

internal class User: Equatable, Comparable, Hashable {
    
    // MARK: Properties
    
    private var _influence: Double = 0.0
    private var _card: Card
    private var _location: CLLocation
    private var _interests: [Interest] = []
    private var _connections: [Connection] = []
    private lazy var _connectedUsers: [User] = {
        var result: [User] = []
        for connection in self.connections() {
            result.append(connection.getConnection(this: self)!)
        }
        
        return result
    }()
    
    // MARK: Initialization
    
    init(card: Card, inf: Double, initPos: CLLocation, connections: [Connection], interests: Interest...) {
        _card = card
        _influence = inf
        _location = initPos // TODO: have method that updates this every 10-20 min
        
        for connection in connections {
            _connections.append(connection)
        }
        
        for interest in interests {
            _interests.append(interest)
        }
        
        // TODO: other initializers, fetch from server or cache for most part
    }
    
    // MARK: Methods
    
    /** Returns the user's influence. */
    func influence() -> Double {
        return _influence
    }
    
    /** Returns the user's card. */
    func card() -> Card {
        return _card
    }
    
    /** Returns the user's location. */
    func location() -> CLLocation {
        return _location
    }
    
    /** Returns the user's interests. */
    func interests() -> [Interest] {
        return _interests
    }
    
    /** Returns the connection objects associated with this user. */
    func connections() -> [Connection] {
        return _connections
    }
    
    /** Returns the users connected to this user. */
    func connectedUsers() -> [User] {
        return _connectedUsers
    }
    
    // MARK: Protocols
    
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.influence() == rhs.influence() &&
            lhs.location() == rhs.location() &&
            lhs.card() == rhs.card()
    }
    
    public static func <(lhs: User, rhs: User) -> Bool {
        return lhs.influence() < rhs.influence()
    }
    
    /** Combines the hash value of each property multiplied by a prime constant. */
    public var hashValue: Int {
        return card().hashValue
            ^ location().hashValue
            ^ influence().hashValue &* 16777619
    }
}
