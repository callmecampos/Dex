//
//  Utils.swift
//  Dex
//
//  Created by Felipe Campos on 12/26/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import Foundation
import UIKit

/** A utility class. */
public class Utils {
    /** A regex pattern checking function.
     Returns whether OBJECT matches PATTERN. */
    static func regex(pattern: String, object: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.firstMatch(in: object,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSMakeRange(0, object.count)) != nil
        } catch {
            return false
        }
    }
    
    /** The regex pattern for testing email validity. */
    static let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}" // TODO: gotta test this bih
    
    /** The regex pattern for testing website validity. */
    static let WEB_REGEX = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" // TODO: gotta test this bih too
    
    /** A prime constant used for calculating hash values. */
    static let HASH_PRIME = 16777619
    
    /** A default image. */
    static let defaultImage = UIImage()
    
    // reference images in assets as vars here (e.g. let chicken = "Assets/chicken.png")
}
