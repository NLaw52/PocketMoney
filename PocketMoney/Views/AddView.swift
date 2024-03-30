//
//  AddView.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/27/24.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Bindable var collection: ExpenseCollection
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = ""
    @State private var vendor = ""
    @State private var category = "Activities"
    @State private var amount = 0.0
    @State private var currency = "USD"
    @State private var date = Date.now
    @State private var note = ""
    @State private var request = false
    @State private var path = [ExpenseItem]()
    
    @StateObject var categories = Categories()
    @StateObject var currencies = Currencies()
        
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    HStack {
                        Text("Name:")
                        
                        TextField("Name", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Vendor:")
                        
                        TextField("Vendor", text: $vendor)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("Category", selection: $category) {
                        ForEach(Array(categories.categories.keys.sorted(by: <)), id: \.self) { key in
                            Text(key)
                        }
                    }
                    
                    HStack {
                        Picker("Currency", selection: $currency) {
                            ForEach(currencies.currencies.sorted(by: <), id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Amount")
                        
                        TextField("Amount", value: $amount, format: .number)                        .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                    
                    HStack {
                        Text("Notes")
                        
                        TextField("Notes", text: $note)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Toggle(isOn: $request) {
                        Text("Request money back?")
                    }
                }
                .listRowBackground(Color("ListCellColor"))
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        let item = ExpenseItem(name: name, vendor: vendor, category: category, currency: currency, amount: amount, date: date, note: note, request: request, collection: collection)
                        
                        modelContext.insert(item)
                        
                        path = [item]
                        
                        dismiss()
                    }
                    Spacer()
                }
            }
            .navigationTitle("Add New Expense")
        }
    }
}

#Preview {
    AddView(collection: ExpenseCollection(name: "Paris", date: Date.now, list: []))
}
