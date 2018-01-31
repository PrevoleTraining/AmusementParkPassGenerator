//
//  DiscountAccess.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * The discount access is a bit different from the other accesses.
 * This access is associated to a percentage granted as a discount in
 * the shops of the park
 */
enum DiscountAccess: Accessable {
    case food(discount: Int)
    case merchandise(discount: Int)
    
    /**
     * Create a discount access from its name and a discount
     *
     * - parameters:
     *  - name: The name of the discount to lookup
     *  - discount: The discount to associate
     *
     * throws: An error of type DiscountAccessError
     */
    static func discount(name: String, discount: Int) throws -> DiscountAccess? {
        switch name {
        case "food": return DiscountAccess.food(discount: discount)
        case "merchandise": return DiscountAccess.merchandise(discount: discount)
        default: throw DiscountAccessError.noSuchDiscountType
        }
    }
    
    func description() -> String {
        switch self {
        case .food(let discount): return "\(discount)% on food"
        case .merchandise(let discount): return "\(discount)% on merchandise"
        }
    }
    
    func isEqualTo(_ rhs: Accessable) -> Bool {
        guard let discountAccess = rhs as? DiscountAccess else {
            return false
        }

        return self == discountAccess
    }
    
    /**
     * Two discount access are equal if the types are equals.
     * The discount can be different.
     *
     * - parameters:
     *  - lhs: Left hand sign discount access
     *  - rhs: Right hand sign discount access
     *
     * returns: True if two discount accesses are of the same type
     */
    static func ==(lhs: DiscountAccess, rhs: DiscountAccess) -> Bool {
        switch (lhs, rhs) {
        case (.food, .food), (.merchandise, .merchandise): return true
        default: return false
        }
    }
}

/**
 * Errors of discount access. The check of the access are
 * managed with a different error enumeration.
 */
enum DiscountAccessError: Error {
    /*
     * When we do not find a enum value from a rawValue
     */
    case noSuchDiscountType
}
