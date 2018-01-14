//
//  DiscountAccess.swift
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 09.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

enum DiscountAccess: Accessable {
    case food(discount: Int)
    case merchandise(discount: Int)
    
    static func discount(name: String, discount: Int) -> DiscountAccess? {
        switch name {
        case "food": return DiscountAccess.food(discount: discount)
        case "merchandise": return DiscountAccess.merchandise(discount: discount)
        default: return nil
        }
    }
    
    func description() -> String {
        switch self {
        case .food(let discount): return "\(discount)% on food"
        case .merchandise(let discount): return "\(discount)% on merchandise"
        }
    }
    
    func discount() -> Int {
        switch self {
        case .food(let discount), .merchandise(let discount): return discount
        }
    }
    
    func isEqualTo(_ rhs: Accessable) -> Bool {
        guard let discountAccess = rhs as? DiscountAccess else {
            return false
        }

        return self == discountAccess
    }
    
    static func ==(lhs: DiscountAccess, rhs: DiscountAccess) -> Bool {
        switch (lhs, rhs) {
        case (.food, .food), (.merchandise, .merchandise): return true
        default: return false
        }
    }
}
