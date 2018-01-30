//
//  AreaRestrictedEntrantable
//  AmusementParkPassGenerator
//
//  Created by PrevoleTraining on 22.01.18.
//  Copyright © 2018 PrevoleTraining. All rights reserved.
//

/**
 * Specific protocol to represent the  access to the different areas
 */
protocol AreaRestrictedEntrantable: Descriptable {
    // The collection of accesses granted into the park
    var accesses: [AreaAccess]? { get }
}
