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

public class User {
    
    // MARK: Properties
    
    private var influence: Double = 0.0
    private var card: Card?
    private var location: CLLocation?
    
    // MARK: Initialization
    
    init(card: Card, inf: Double, initPos: CLLocation) {
        self.card = card
        self.influence = inf
        self.location = initPos // have method that updates this every 10-20 min
        // other initializers, fetch from server for most part
    }
    
    // MARK: Methods
}
