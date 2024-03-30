//
//  PocketMoneyApp.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/27/24.
//

import SwiftData
import SwiftUI

@main
struct PocketMoneyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ExpenseCollection.self, ExpenseItem.self])
    }
}
