//
//  Interest.swift
//  Dex
//
//  Created by Felipe Campos on 12/23/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation

/** An interest class defining an instance of a user's interest or skill. */
internal class Interest: Equatable, Hashable {
    
    enum Variety {
        case any
        case business
        case consulting
        case design
        case engineering
        case entrepreneurship
        case software
        case sports
        // TODO: refine and add cases
    }
    
    // MARK: Properties
    
    /** The interest name. */
    private var _name: String
    
    /** The interest description. */
    private var _description: String
    
    /** The interest weight. */
    private var _weight: Double
    
    /** The interest type. */
    private var _type: Interest.Variety
    
    // MARK: Initialization
    
    init(name: String, desc: String, weight: Double, type: Interest.Variety) {
        _name = name
        _description = desc
        _weight = weight
        _type = type
    }
    
    // MARK: Methods
    
    /** Returns the interest name. */
    func name() -> String {
        return _name
    }
    
    /** Return's the interest description. */
    func description() -> String {
        return _description
    }
    
    /** Return's the interest weight. */
    func weight() -> Double {
        return _weight
    }
    
    /** Return's the interest type (business, software, entrepreneurship, etc.). */
    func type() -> Interest.Variety {
        return _type
    }
    
    // MARK: Protocols
    
    static func ==(lhs: Interest, rhs: Interest) -> Bool {
        return lhs.name() == rhs.name() && lhs.description() == rhs.description()
        && lhs.weight() == rhs.weight() && lhs.type() == rhs.type()
    }
    
    /** Combines the hash value of each property
     multiplied by a prime constant. */
    var hashValue: Int {
        return _name.hashValue ^ _description.hashValue ^
            _weight.hashValue ^ _type.hashValue &* Utils.HASH_PRIME
    }
}
