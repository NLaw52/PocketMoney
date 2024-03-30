//
//  ContentView.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/27/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\ExpenseCollection.date, order: .reverse)]) var collections: [ExpenseCollection]
    
    @State private var showingAddCollection = false
    @State private var exchangeRates: ExchangeRates?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(collections, id: \.self) { collection in
                    NavigationLink {
                        ExpensesView(collection: collection)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(collection.name)
                                Text(collection.date, style: .date)
                                    .font(.caption)
                            }
                        }
                    }
                }
                .onDelete(perform: removeItems)
                .listRowBackground(Color("CollectionCellColor"))
            }
            .task {
                await loadData()
                
                print(exchangeRates?.rates ?? 0.0)

            }
            .navigationTitle("Expense Collections")
            .toolbar {
                Button("Add Collection", systemImage: "plus") {
                    showingAddCollection = true
                }
            }
            .sheet(isPresented: $showingAddCollection) {
                AddCollectionView()
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let collection = collections[offset]
            modelContext.delete(collection)
        }
    }
    
    func loadData() async {
        let appId = "9e7d352e2c23474e91726992e311c082"
        let baseCurrency = "USD"
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(appId)&base=\(baseCurrency)") else {
            print("Invalid URL")
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? decoder.decode(ExchangeRates.self, from: data) {
                exchangeRates = decodedResponse
            }
        } catch {
            print("Could not decode JSON")
        }
    }
}

#Preview {
    ContentView()
}
