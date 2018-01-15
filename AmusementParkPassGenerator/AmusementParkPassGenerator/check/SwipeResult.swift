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
 */
struct SwipeResult: CustomStringConvertible {
    var status: Status
    var messages: [String] = []
    
    var description: String {
        switch status {
        case .granted: return "Access authorized"
        case .grantedForDiscount(let discount): return "Access authorized for discount: \(discount.description())"
        case .denied: return "Access denied"
        }
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
     */
    init(status: Status, message: String) {
        self.init(status: status)
        self.messages.append(message)
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

