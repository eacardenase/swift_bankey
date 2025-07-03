//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/2/25.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
