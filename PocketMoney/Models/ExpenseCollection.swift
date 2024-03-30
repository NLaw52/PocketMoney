//
//  ExpenseCollection.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/28/24.
//

import Foundation
import SwiftData

@Model
class ExpenseCollection {
    var name: String
    var date: Date
    @Relationship(deleteRule: .cascade, inverse: \ExpenseItem.collection) var list: [ExpenseItem]
    
    init(name: String, date: Date, list: [ExpenseItem]) {
        self.name = name
        self.date = date
        self.list = list
    }
}
