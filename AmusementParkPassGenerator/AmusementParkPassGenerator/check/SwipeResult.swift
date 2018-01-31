//
//  SwipeResult.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 11.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Contains the satus of the check verification of an access
 * and a list of messages related to the access verfications done.
 *
 * Additional flags like birthDateMessage are present to
 * specialize the access/deny message
 */
struct SwipeResult: CustomStringConvertible {
    var status: Status
    var messages: [String] = []
    var birthDateMessage: Bool = false
    var tooFast: Bool = false
    
    var description: String {
        var message: String
        
        switch status {
        case .granted: message = "Access authorized"
        case .grantedForDiscount(let discount): message = "Access authorized for discount: \(discount.description())"
        case .denied: message = "Access denied"
        }
        
        if birthDateMessage && !message.contains("denied") {
            message += ", Happy Birthday! Enjoy the day in our Theme Park"
        } else if tooFast {
            message += ", You attemtped to cheat at the access control!"
        }
        
        return message
    }

    /**
     * Constructor
     *
     * - parameter status: The status of the check
     */
    init(status: Status) {
        self.status = status
    }
    
    /**
     * Constructor
     *
     * - parameter status: The status of the check
     * - parameter message: Short message to associate with status
     * - parameter message: Attempt to check access too fast
     */
    init(status: Status, message: String, tooFast: Bool = false) {
        self.init(status: status)
        self.messages.append(message)
        self.tooFast = tooFast
    }
    
    /**
     * Add more message to the result
     *
     * - parameter message: The message to add
     */
    mutating func add(message: String) {
        messages.append(message)
    }
    
    /**
     * The access check status
     */
    enum Status {
        // The pass gives the access
        case granted
        
        // The pass gives the access to a shop discount
        case grantedForDiscount(discount: DiscountAccess)
        
        // The pass does not give the access
        case denied
    }
}

