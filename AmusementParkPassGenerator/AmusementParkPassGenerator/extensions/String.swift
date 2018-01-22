//
//  String.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 10.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

// See: https://stackoverflow.com/a/26306372/1618785
extension String {
    /**
     * Capitalize the first letter of a string
     *
     *  - returns: The new string with first letter capitalized
     */
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    /**
     * Captitalize the first letter of a string
     */
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    /**
     * Check if a string match a pattern
     *
     * - parameter pattern: The pattern to search
     *
     * - returns: True if found, false otherwise
     */
    func match(pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
