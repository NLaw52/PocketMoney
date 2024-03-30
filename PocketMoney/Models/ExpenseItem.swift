//
//  ExpenseItem.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/27/24.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {   
    var name: String
    var vendor: String
    var category: String
    var currency: String
    var amount: Double
    var date: Date
    var note: String
    var request: Bool
    var collection: ExpenseCollection?
    
    // Add picture of receipt

    init(name: String, vendor: String, category: String, currency: String, amount: Double, date: Date, note: String, request: Bool, collection: ExpenseCollection?) {
        self.name = name
        self.vendor = vendor
        self.category = category
        self.currency = currency
        self.amount = amount
        self.date = date
        self.note = note
        self.request = request
        self.collection = collection
    }
}
