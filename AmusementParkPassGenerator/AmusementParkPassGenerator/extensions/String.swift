//
//  String.swift
//  AmusementParkPassGenerator
//
//  Created by lprevost on 10.01.18.
//  Copyright © 2018 prevole.ch. All rights reserved.
//

// See: https://stackoverflow.com/a/26306372/1618785
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
