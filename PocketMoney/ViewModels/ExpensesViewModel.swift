//
//  ExpensesViewModel.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/28/24.
//

import Foundation

extension ExpensesView {
    
    @Observable
    class ViewModel {
        var total: Double = 0.0
        
        private(set) var expenses = [ExpenseItem]()
        
        func sumExpenses(expenses: [ExpenseItem]) -> Double {
            total = 0.0
            
            for expense in expenses {
                total += expense.amount
            }
            
            return total
        }
    }
}
