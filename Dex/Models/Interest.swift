//
//  Interest.swift
//  Dex
//
//  Created by Felipe Campos on 12/23/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation

internal class Interest {
    
    enum Variety {
        case any
        case business
        case entrepeneurship
        case software
    }
    
    // MARK: Properties
    
    private var _name: String = ""
    private var _description: String = ""
    private var _weight: Double = 0.0
    private var _type: Interest.Variety
    
    // MARK: Initialization
    
    init(name: String, desc: String, weight: Double, type: Interest.Variety) {
        _name = name
        _description = desc
        _weight = weight
        _type = type
    }
    
    // MARK: Methods
    
    func name() -> String {
        return _name
    }
    
    func description() -> String {
        return _description
    }
    
    func weight() -> Double {
        return _weight
    }
    
    func type() -> Interest.Variety {
        return _type
    }
}
