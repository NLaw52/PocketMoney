//
//  AddCollectionView.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/28/24.
//

import SwiftUI

struct AddCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = ""
    @State private var date = Date.now
    @State private var list = [ExpenseItem]()
    @State private var path = [ExpenseCollection]()
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    HStack {
                        Text("Name:")
                        
                        TextField("Name", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .listRowBackground(Color("CollectionCellColor"))

                HStack {
                    Spacer()
                    
                    Button("Submit") {
                        let collection = ExpenseCollection(name: name, date: date, list: list)
                        
                        modelContext.insert(collection)
                        
                        path = [collection]
                        
                        dismiss()
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Add New Collection")
        }
    }
}

#Preview {
    AddCollectionView()
}
