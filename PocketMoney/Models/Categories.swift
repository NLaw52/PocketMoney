//
//  Categories.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/27/24.
//

import Foundation
import SwiftUI

class Categories: ObservableObject {
    @Published var categories = ["Activities": Color("#C89696"),
                                 "Clothing": Color("#A4B8B8"),
                                 "Entertainment": Color("#F0C9A6"),
                                 "Food": Color("#C6A4C6"),
                                 "Lodging": Color("#AAC6B8"),
                                 "Medical": Color("#C6AFC6"),
                                 "Toiletries": Color("#E9B8C7"),
                                 "Transportation": Color("#9DC6C6")
    ]
}

