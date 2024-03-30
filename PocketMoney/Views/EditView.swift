//
//  EditView.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/27/24.
//

import SwiftData
import SwiftUI

struct EditView: View {
    @Bindable var expense: ExpenseItem
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @StateObject var categories = Categories()
    @StateObject var currencies = Currencies()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Name:")
                        
                        TextField("Name", text: $expense.name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Vendor:")
                        
                        TextField("Vendor", text: $expense.vendor)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("Category", selection: $expense.category) {
                        ForEach(Array(categories.categories.keys.sorted(by: <)), id: \.self) { key in
                            Text(key)
                        }
                    }
                    
                    HStack {
                        Picker("Currency", selection: $expense.currency) {
                            ForEach(currencies.currencies.sorted(by: <), id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Amount")
                        
                        TextField("Amount", value: $expense.amount, format: .number)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker("Date", selection: $expense.date, displayedComponents: [.date])
                    
                    HStack {
                        Text("Notes")
                        
                        TextField("Notes", text: $expense.note)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Toggle(isOn: $expense.request) {
                        Text("Request money back?")
                    }
                }
                .listRowBackground(Color("ListCellColor"))
                
                HStack {
                    Spacer()
                    Button("Update") {
                        dismiss()
                    }
                    Spacer()
                }
            }
            .navigationTitle("Edit Expense")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        let example = ExpenseItem(name: "Coffee", vendor: "Starbucks", category: "Food & Drinks", currency: "USD", amount: 6.75, date: Date.now, note: "", request: false, collection: ExpenseCollection(name: "Paris", date: Date.now, list: []))
        
        return EditView(expense: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
