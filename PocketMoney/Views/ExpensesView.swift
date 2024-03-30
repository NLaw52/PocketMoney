//
//  ExpensesView.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/28/24.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Bindable var collection: ExpenseCollection
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\ExpenseItem.date, order: .reverse)]) var expenses: [ExpenseItem]
    
    @State private var showingAddExpense = false
    @State private var viewModel = ViewModel()
    @State private var total = 0.0
    
    @StateObject var categories = Categories()
    
    var body: some View {
        let expenses = collection.list
        
        NavigationStack {
            Section {
                List {
                    ForEach(expenses, id: \.self) { item in
                        NavigationLink {
                            EditView(expense: item)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    
                                    Text(item.date, style: .date)
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                Text(String(format: "%.2f", item.amount))
                                    .font(.title)
                                Text(item.currency)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                    .listRowBackground(Color("ListCellColor"))
                }
                .listStyle(.grouped)
                .navigationTitle("Expenses")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                .sheet(isPresented: $showingAddExpense, onDismiss: {
                    total = viewModel.sumExpenses(expenses: expenses)
                }, content: {
                    AddView(collection: collection)
                })
            }
            
            HStack {
                Text("Total:")
                Text(String(format: "%.2f", total))
            }
        }
        .onAppear {
            total = viewModel.sumExpenses(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseCollection.self, configurations: config)
        let example = ExpenseCollection(name: "Paris", date: Date.now, list: [])
        
        return ExpensesView(collection: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
